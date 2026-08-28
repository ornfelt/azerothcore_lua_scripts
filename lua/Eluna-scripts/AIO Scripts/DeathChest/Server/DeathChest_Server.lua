-- DeathChest_Server.lua
-- Handles player death, item collection, GameObject spawn, and AIO communication

local AIO = require("AIO")
local Config = DeathChestConfig
local IS_MAIN_STATE = not GetStateMapId or GetStateMapId() == -1
local CHEST_TABLE = Config.DB_NAME .. "." .. Config.TABLE_NAME

-- In-memory tracking (per map state)
local playerChests = {}  -- [playerGuidLow] = { go = reference, guid = number }
local chestObjects = {}  -- [chestGuidLow] = gameobject reference

-- Tracks chests that might be empty (set by RefreshList in main state, checked in map state)
local pendingEmptyCheck = {} -- [chestGuidLow] = true
local pendingOpener = {} -- [chestGuidLow] = player reference (event 14 → event 9)

-- Rate limiter: prevent handler spam
local lastAction = {} -- [playerGuidLow] = os.clock() timestamp
local ACTION_COOLDOWN = 0.5
local function isRateLimited(playerGuid)
    local now = os.clock()
    if lastAction[playerGuid] and (now - lastAction[playerGuid]) < ACTION_COOLDOWN then
        return true
    end
    lastAction[playerGuid] = now
    return false
end

--- Check if player is within interaction distance of a chest (via DB position).
local function isPlayerInRange(player, chestGuid)
    local q = CharDBQuery(string.format(
        "SELECT pos_x, pos_y, pos_z, map_id FROM %s WHERE creature_guid = %d LIMIT 1",
        CHEST_TABLE, chestGuid
    ))
    if not q then return false end
    local cx, cy, cz, cMap = q:GetFloat(0), q:GetFloat(1), q:GetFloat(2), q:GetUInt32(3)
    if player:GetMapId() ~= cMap then return false end
    local dx, dy, dz = player:GetX() - cx, player:GetY() - cy, player:GetZ() - cz
    return (dx*dx + dy*dy + dz*dz) <= (Config.INTERACTION_DISTANCE * Config.INTERACTION_DISTANCE)
end

--- Remove a chest GO permanently from the world.
local function removeChest(chestGuid)
    local go = chestObjects[chestGuid]
    if go and go:IsInWorld() then
        go:RemoveFromWorld(true)
    end
    chestObjects[chestGuid] = nil
end

--- Delayed refresh helper for AIO handlers.
local function delayedRefresh(player, chestGuid, refreshFn)
    local pGuid = player:GetGUIDLow()
    CreateLuaEvent(function()
        local p = GetPlayerByGUID(GetPlayerGUID(pGuid))
        if p then refreshFn(p, chestGuid) end
    end, 200, 1)
end

--- Check if an item should be dropped based on config filters.
local function shouldDropItem(item)
    local entry = item:GetEntry()
    if Config.BLACKLISTED_ITEMS[entry] then
        return false
    end
    if Config.MIN_ITEM_QUALITY > 0 then
        local _, _, rarity = GetItemInfo(entry)
        if rarity and rarity < Config.MIN_ITEM_QUALITY then
            return false
        end
    end
    if Config.DROP_MODE == "RANDOM" then
        if math.random(100) > Config.RANDOM_DROP_PERCENT then
            return false
        end
    end
    return true
end

--- Collect items from a single bag slot.
local function collectFromSlot(player, bag, slot, collected)
    local item = player:GetItemByPos(bag, slot)
    if item and shouldDropItem(item) then
        collected[#collected + 1] = { entry = item:GetEntry(), count = item:GetCount() }
        player:RemoveItem(item, item:GetCount())
    end
end

--- Collect all droppable items from the player's inventory.
local function collectPlayerItems(player)
    local collected = {}

    if Config.DROP_EQUIPPED then
        for slot = Config.EQUIP_SLOT_MIN, Config.EQUIP_SLOT_MAX do
            collectFromSlot(player, 255, slot, collected)
        end
    end

    if Config.DROP_BAG_ITEMS then
        for slot = Config.BACKPACK_SLOT_MIN, Config.BACKPACK_SLOT_MAX do
            collectFromSlot(player, 255, slot, collected)
        end
        for bag = Config.BAG_SLOT_MIN, Config.BAG_SLOT_MAX do
            local bagItem = player:GetItemByPos(255, bag)
            if bagItem then
                for slot = 0, bagItem:GetBagSize() - 1 do
                    collectFromSlot(player, bag, slot, collected)
                end
            end
        end
    end

    return collected
end

--- Collect gold from the player based on config percentage.
local function collectPlayerGold(player)
    if not Config.DROP_GOLD then return 0 end
    local currentGold = player:GetCoinage()
    local dropAmount = math.floor(currentGold * Config.GOLD_PERCENT / 100)
    if dropAmount > 0 then
        player:ModifyMoney(-dropAmount)
    end
    return dropAmount
end

--- Restore items to the player (rollback on spawn failure).
local function restoreItems(player, items, gold)
    for _, item in ipairs(items) do
        player:AddItem(item.entry, item.count)
    end
    if gold > 0 then
        player:ModifyMoney(gold)
    end
end

--- Build and execute SQL to insert all items + gold into DB (synchronous).
local function storeItemsInDB(playerGuid, items, gold, mapId, x, y, z)
    local values = {}
    for _, item in ipairs(items) do
        values[#values + 1] = string.format(
            "(%d, 0, %d, %d, %d, %.2f, %.2f, %.2f)",
            playerGuid, item.entry, item.count, mapId, x, y, z
        )
    end
    if gold > 0 then
        values[#values + 1] = string.format(
            "(%d, 0, 0, %d, %d, %.2f, %.2f, %.2f)",
            playerGuid, gold, mapId, x, y, z
        )
    end
    if #values == 0 then return end
    CharDBQuery(string.format(
        "INSERT INTO %s (player_guid, creature_guid, item_entry, item_count, map_id, pos_x, pos_y, pos_z) VALUES %s",
        CHEST_TABLE, table.concat(values, ", ")
    ))
end

--- Clean up old chest data for a player (synchronous).
local function cleanupOldChest(playerGuid)
    CharDBQuery(string.format("DELETE FROM %s WHERE player_guid = %d", CHEST_TABLE, playerGuid))
    local entry = playerChests[playerGuid]
    if entry then
        removeChest(entry.guid)
    end
    playerChests[playerGuid] = nil
end

--- Spawn the death chest GameObject at the player's death location.
local function spawnDeathChest(player, items, gold)
    local playerGuid = player:GetGUIDLow()
    local mapId = player:GetMapId()
    local instanceId = player:GetInstanceId()
    local x, y, z, o = player:GetX(), player:GetY(), player:GetZ(), player:GetO()

    if Config.MAX_CHESTS_PER_PLAYER > 0 then
        cleanupOldChest(playerGuid)
    end

    storeItemsInDB(playerGuid, items, gold, mapId, x, y, z)

    local chest = PerformIngameSpawn(2, Config.OBJECT_ENTRY, mapId, instanceId, x, y, z, o, false, 0, 1)

    if not chest then
        restoreItems(player, items, gold)
        CharDBExecute(string.format("DELETE FROM %s WHERE player_guid = %d", CHEST_TABLE, playerGuid))
        player:SendBroadcastMessage("|cffff4444Failed to create death chest. Items restored.|r")
        return nil
    end

    local chestGuid = chest:GetGUIDLow()
    CharDBQuery(string.format(
        "UPDATE %s SET creature_guid = %d WHERE player_guid = %d AND creature_guid = 0",
        CHEST_TABLE, chestGuid, playerGuid
    ))
    playerChests[playerGuid] = { go = chest, guid = chestGuid }
    chestObjects[chestGuid] = chest

    -- Force remove after DESPAWN_TIME
    local despawnMs = Config.DESPAWN_TIME * 1000
    CreateLuaEvent(function()
        removeChest(chestGuid)
        CharDBExecute(string.format(
            "DELETE FROM %s WHERE player_guid = %d AND creature_guid = %d",
            CHEST_TABLE, playerGuid, chestGuid
        ))
        -- Only clear if this is still the active chest (compare by guid number)
        local current = playerChests[playerGuid]
        if current and current.guid == chestGuid then
            playerChests[playerGuid] = nil
        end
    end, despawnMs, 1)

    return chest
end

--- Main death handler.
local function onPlayerDeath(event, killer, player)
    local items = collectPlayerItems(player)
    local gold = collectPlayerGold(player)

    if #items == 0 and gold == 0 then return end

    local chest = spawnDeathChest(player, items, gold)
    if Config.ANNOUNCE_DEATH and chest then
        player:SendBroadcastMessage("|cffff4444Your belongings have been dropped at your death location!|r")
    end
end

--- GameObject use: ownership pre-check, let native cast bar proceed.
local function onChestUse(event, go, player)
    local chestGuid = go:GetGUIDLow()

    local query = CharDBQuery(string.format(
        "SELECT player_guid FROM %s WHERE creature_guid = %d LIMIT 1",
        CHEST_TABLE, chestGuid
    ))

    if not query then
        player:SendBroadcastMessage("|cff888888This chest is empty.|r")
        removeChest(chestGuid)
        return true -- block interaction on empty chest
    end

    if not Config.ANYONE_CAN_LOOT and query:GetUInt32(0) ~= player:GetGUIDLow() then
        player:SendBroadcastMessage("|cffff4444This is not your death chest.|r")
        return true -- block non-owners before cast starts
    end

    if not player:IsAlive() then return true end

    pendingOpener[chestGuid] = player
    return false -- let native cast bar proceed (server-validated)
end

--- Native cast bar completed: send items to player.
local function onChestLootStateChange(event, go, state)
    if state ~= 2 then return end -- GO_ACTIVATED = cast bar completed
    local chestGuid = go:GetGUIDLow()
    local player = pendingOpener[chestGuid]
    pendingOpener[chestGuid] = nil

    if not player or not player:IsInWorld() or not player:IsAlive() then return end

    local query = CharDBQuery(string.format(
        "SELECT id, item_entry, item_count FROM %s WHERE creature_guid = %d ORDER BY id",
        CHEST_TABLE, chestGuid
    ))
    if not query then return end

    local itemData = {}
    repeat
        itemData[#itemData + 1] = {
            id = query:GetUInt32(0),
            entry = query:GetUInt32(1),
            count = query:GetUInt32(2),
        }
    until not query:NextRow()

    AIO.Handle(player, "DeathChest", "Open", itemData, chestGuid)
end

-- Periodic checker: remove empty chests (runs in map states)
if not IS_MAIN_STATE then
    CreateLuaEvent(function()
        for chestGuid, _ in pairs(chestObjects) do
            local query = CharDBQuery(string.format(
                "SELECT 1 FROM %s WHERE creature_guid = %d LIMIT 1", CHEST_TABLE, chestGuid
            ))
            if not query then
                removeChest(chestGuid)
            end
        end
    end, 2000, 0) -- check every 2s
end

-- AIO Handlers (main state only)
if IS_MAIN_STATE then
    local Handlers = AIO.AddHandlers("DeathChest", {})

    local function validateChestAccess(player, chestGuid)
        local ownerQuery = CharDBQuery(string.format(
            "SELECT player_guid FROM %s WHERE creature_guid = %d LIMIT 1",
            CHEST_TABLE, chestGuid
        ))
        if not ownerQuery then return false end
        if not Config.ANYONE_CAN_LOOT and ownerQuery:GetUInt32(0) ~= player:GetGUIDLow() then
            AIO.Handle(player, "DeathChest", "Error", "Not your chest!")
            return false
        end
        if not isPlayerInRange(player, chestGuid) then
            AIO.Handle(player, "DeathChest", "ForceClose")
            return false
        end
        return true
    end

    local function giveItemsToPlayer(player, query)
        local idsToDelete = {}
        repeat
            local id = query:GetUInt32(0)
            local itemEntry = query:GetUInt32(1)
            local itemCount = query:GetUInt32(2)
            if itemEntry == 0 then
                player:ModifyMoney(itemCount)
                idsToDelete[#idsToDelete + 1] = id
            else
                local added = player:AddItem(itemEntry, itemCount)
                if added then
                    idsToDelete[#idsToDelete + 1] = id
                end
            end
        until not query:NextRow()
        if #idsToDelete > 0 then
            CharDBExecute(string.format(
                "DELETE FROM %s WHERE id IN (%s)", CHEST_TABLE, table.concat(idsToDelete, ",")
            ))
        end
        return idsToDelete
    end

    function Handlers.TakeItem(player, rowId)
        if type(rowId) ~= "number" or rowId <= 0 or rowId ~= math.floor(rowId) then return end
        local playerGuid = player:GetGUIDLow()
        if not player:IsAlive() or isRateLimited(playerGuid) then return end

        local query = CharDBQuery(string.format(
            "SELECT item_entry, item_count, player_guid, creature_guid FROM %s WHERE id = %d",
            CHEST_TABLE, rowId
        ))
        if not query then return end

        local itemEntry = query:GetUInt32(0)
        local itemCount = query:GetUInt32(1)
        local ownerGuid = query:GetUInt32(2)
        local chestGuid = query:GetUInt32(3)

        if not Config.ANYONE_CAN_LOOT and ownerGuid ~= playerGuid then
            AIO.Handle(player, "DeathChest", "Error", "Not your chest!")
            return
        end

        if not isPlayerInRange(player, chestGuid) then
            AIO.Handle(player, "DeathChest", "ForceClose")
            return
        end

        if itemEntry == 0 then
            player:ModifyMoney(itemCount)
        else
            local added = player:AddItem(itemEntry, itemCount)
            if not added then
                AIO.Handle(player, "DeathChest", "Error", "Your bags are full!")
                return
            end
        end

        CharDBExecute(string.format("DELETE FROM %s WHERE id = %d", CHEST_TABLE, rowId))
        delayedRefresh(player, chestGuid, Handlers.RefreshList)
    end

    function Handlers.TakeAll(player, chestGuid)
        if type(chestGuid) ~= "number" or chestGuid <= 0 then return end
        if not player:IsAlive() or isRateLimited(player:GetGUIDLow()) then return end
        if not validateChestAccess(player, chestGuid) then return end
        local query = CharDBQuery(string.format(
            "SELECT id, item_entry, item_count FROM %s WHERE creature_guid = %d ORDER BY id",
            CHEST_TABLE, chestGuid
        ))
        if not query then return end
        giveItemsToPlayer(player, query)
        delayedRefresh(player, chestGuid, Handlers.RefreshList)
    end

    function Handlers.TakeMultiple(player, chestGuid, rowIds)
        if type(chestGuid) ~= "number" or chestGuid <= 0 then return end
        if type(rowIds) ~= "table" or #rowIds == 0 or #rowIds > 200 then return end
        if not player:IsAlive() or isRateLimited(player:GetGUIDLow()) then return end
        if not validateChestAccess(player, chestGuid) then return end
        local sanitized = {}
        for _, id in ipairs(rowIds) do
            if type(id) == "number" and id > 0 and id == math.floor(id) then
                sanitized[#sanitized + 1] = id
            end
        end
        if #sanitized == 0 then return end
        local query = CharDBQuery(string.format(
            "SELECT id, item_entry, item_count FROM %s WHERE creature_guid = %d AND id IN (%s) ORDER BY id",
            CHEST_TABLE, chestGuid, table.concat(sanitized, ",")
        ))
        if not query then return end
        giveItemsToPlayer(player, query)
        delayedRefresh(player, chestGuid, Handlers.RefreshList)
    end

    function Handlers.RefreshList(player, chestGuid)
        local query = CharDBQuery(string.format(
            "SELECT id, item_entry, item_count FROM %s WHERE creature_guid = %d ORDER BY id",
            CHEST_TABLE, chestGuid
        ))

        local itemData = {}
        if query then
            repeat
                itemData[#itemData + 1] = {
                    id = query:GetUInt32(0),
                    entry = query:GetUInt32(1),
                    count = query:GetUInt32(2),
                }
            until not query:NextRow()
        end

        -- Empty chest will be auto-removed by map state periodic checker

        AIO.Handle(player, "DeathChest", "UpdateList", itemData)
    end

    -- Distance check system (auto-close UI when player moves away)
    local activeDistanceChecks = {} -- [playerGuid] = token

    local function stopDistanceCheck(guid)
        activeDistanceChecks[guid] = nil
    end

    local function startDistanceCheck(pGuid, cx, cy, cz, cMap)
        local token = {}
        activeDistanceChecks[pGuid] = token
        local dist2 = Config.INTERACTION_DISTANCE * Config.INTERACTION_DISTANCE

        local function tick()
            if activeDistanceChecks[pGuid] ~= token then return end
            local p = GetPlayerByGUID(GetPlayerGUID(pGuid))
            if not p or p:GetMapId() ~= cMap then
                activeDistanceChecks[pGuid] = nil
                if p then AIO.Handle(p, "DeathChest", "ForceClose") end
                return
            end
            local dx, dy, dz = p:GetX() - cx, p:GetY() - cy, p:GetZ() - cz
            if (dx*dx + dy*dy + dz*dz) > dist2 then
                AIO.Handle(p, "DeathChest", "ForceClose")
                activeDistanceChecks[pGuid] = nil
                return
            end
            CreateLuaEvent(tick, 1000, 1)
        end

        CreateLuaEvent(tick, 1000, 1)
    end

    --- Client notifies server when chest UI is displayed (starts distance monitor).
    function Handlers.UIOpened(player, chestGuid)
        if type(chestGuid) ~= "number" or chestGuid <= 0 then return end
        local posQ = CharDBQuery(string.format(
            "SELECT pos_x, pos_y, pos_z, map_id FROM %s WHERE creature_guid = %d LIMIT 1",
            CHEST_TABLE, chestGuid
        ))
        if not posQ then return end
        startDistanceCheck(
            player:GetGUIDLow(),
            posQ:GetFloat(0), posQ:GetFloat(1), posQ:GetFloat(2), posQ:GetUInt32(3)
        )
    end

    function Handlers.CloseUI(player)
        stopDistanceCheck(player:GetGUIDLow())
    end
end

-- Event Registration (runs in all states)
RegisterPlayerEvent(6, onPlayerDeath)
RegisterPlayerEvent(8, onPlayerDeath)
RegisterGameObjectEvent(Config.OBJECT_ENTRY, 14, onChestUse)
RegisterGameObjectEvent(Config.OBJECT_ENTRY, 9, onChestLootStateChange)

print("[DeathChest] System loaded (state: " .. (GetStateMapId and GetStateMapId() or "world") .. ")")
