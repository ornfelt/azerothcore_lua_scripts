--[[
    GameMaster UI - Player Inventory Data Handlers Sub-Module
    
    This sub-module handles inventory data queries and bag mapping:
    - Character GUID queries
    - Bag mapping and configuration
    - Equipment data queries
    - Inventory data compilation
    - Bag size calculations
]]--

local PlayerInventoryDataHandlers = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper

function PlayerInventoryDataHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    
    -- Register data query handlers
    GameMasterSystem._queryAndSendInventory = PlayerInventoryDataHandlers.queryAndSendInventory
end

-- Internal function to query and send inventory data
function PlayerInventoryDataHandlers.queryAndSendInventory(player, targetName)
    
    -- Get character GUID
    local guidQuery = CharDBQuery(string.format(
        "SELECT guid FROM characters WHERE name = '%s'",
        targetName
    ))
    
    if not guidQuery then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found in database.")
        AIO.Handle(player, "GameMasterSystem", "receiveInventoryData", {}, {}, targetName)
        return
    end
    
    local characterGuid = guidQuery:GetUInt32(0)
    
    -- Get bag mapping
    local bagMapping, bagItemToSlot = PlayerInventoryDataHandlers.getBagMapping(characterGuid, targetName)
    
    -- Get inventory data
    local inventoryData, foundBagIds, bagIdToInfo = PlayerInventoryDataHandlers.getInventoryData(characterGuid, bagMapping)
    
    -- Get bank data (main bank slots from bag 0, slots 39-66)
    local bankData = PlayerInventoryDataHandlers.getBankData(characterGuid)
    
    -- Get equipment data
    local equipmentData = PlayerInventoryDataHandlers.getEquipmentData(targetName, characterGuid)
    
    -- Get bag sizes
    local bagSizes = PlayerInventoryDataHandlers.getBagSizes(targetName, characterGuid, bagMapping, bagItemToSlot, inventoryData, foundBagIds)
    
    -- Create bag configuration
    local bagConfiguration = PlayerInventoryDataHandlers.createBagConfiguration(bagSizes, bagIdToInfo)
    
    -- Get player stats
    local playerStats = PlayerInventoryDataHandlers.getPlayerStats(targetName, characterGuid)
    
    -- Send data to client
    local equipmentCount = 0
    for _ in pairs(equipmentData) do
        equipmentCount = equipmentCount + 1
    end
    
    
    Utils.sendMessage(player, "success", string.format("Loaded inventory for %s (%d items, %d equipped, %d bank)", 
        targetName, #inventoryData, equipmentCount, #bankData))
    
    AIO.Handle(player, "GameMasterSystem", "receiveInventoryData", inventoryData, equipmentData, targetName, bagConfiguration, bankData, playerStats)
end

-- Get bag mapping for a character
function PlayerInventoryDataHandlers.getBagMapping(characterGuid, targetName)
    local bagMapping = {}
    local bagItemToSlot = {}
    
    -- First, get all equipped bags from the main inventory (bag 0 in database = bag 255 in Eluna API)
    -- Bags are equipped in slots 19-22 of the main inventory container
    local bagMappingQuery = string.format([[
        SELECT 
            ci.slot,
            ci.item,
            ii.itemEntry,
            it.ContainerSlots,
            it.name
        FROM character_inventory ci
        JOIN item_instance ii ON ci.item = ii.guid
        JOIN world.item_template it ON ii.itemEntry = it.entry
        WHERE ci.guid = %d 
        AND ci.bag = 0 
        AND ci.slot >= 19 AND ci.slot <= 22
        AND it.class = 1
    ]], characterGuid)
    
    local bagMappingResult = CharDBQuery(bagMappingQuery)
    
    if bagMappingResult then
        repeat
            local slot = bagMappingResult:GetUInt32(0)
            local itemGuid = bagMappingResult:GetUInt32(1)
            local itemEntry = bagMappingResult:GetUInt32(2)
            local containerSlots = bagMappingResult:GetUInt32(3)
            local bagName = bagMappingResult:GetString(4)
            
            bagMapping[itemGuid] = {
                slot = slot,
                itemEntry = itemEntry,
                size = containerSlots,
                name = bagName,
                type = "regular"
            }
            bagItemToSlot[itemGuid] = slot
            
            print(string.format("[PlayerInventoryDataHandlers] Found equipped bag: %s (GUID: %d) at slot %d with %d slots", 
                bagName, itemGuid, slot, containerSlots))
        until not bagMappingResult:NextRow()
    end
    
    -- Check for bank bags (slots 67-74 in bag 0) - WoW 3.3.5 has 7 bank bag slots (67-73)
    local bankBagQuery = string.format([[
        SELECT 
            ci.slot,
            ci.item,
            ii.itemEntry,
            it.ContainerSlots,
            it.name
        FROM character_inventory ci
        JOIN item_instance ii ON ci.item = ii.guid
        JOIN world.item_template it ON ii.itemEntry = it.entry
        WHERE ci.guid = %d 
        AND ci.bag = 0 
        AND ci.slot >= 67 AND ci.slot <= 73
        AND it.class = 1
    ]], characterGuid)
    
    local bankBagResult = CharDBQuery(bankBagQuery)
    if bankBagResult then
        repeat
            local slot = bankBagResult:GetUInt32(0)
            local itemGuid = bankBagResult:GetUInt32(1)
            local itemEntry = bankBagResult:GetUInt32(2)
            local containerSlots = bankBagResult:GetUInt32(3)
            local bagName = bankBagResult:GetString(4)
            
            bagMapping[itemGuid] = {
                slot = slot,
                itemEntry = itemEntry,
                size = containerSlots,
                name = bagName,
                type = "bank"
            }
            bagItemToSlot[itemGuid] = slot
            
            print(string.format("[PlayerInventoryDataHandlers] Found bank bag: %s (GUID: %d) at slot %d with %d slots", 
                bagName, itemGuid, slot, containerSlots))
        until not bankBagResult:NextRow()
    end
    
    return bagMapping, bagItemToSlot
end

-- Get inventory data from character_inventory
function PlayerInventoryDataHandlers.getInventoryData(characterGuid, bagMapping)
    local inventoryQuery = string.format([[
        SELECT 
            ci.bag,
            ci.slot,
            ci.item,
            ii.itemEntry,
            ii.count,
            ii.owner_guid,
            ii.enchantments
        FROM character_inventory ci
        JOIN item_instance ii ON ci.item = ii.guid
        WHERE ci.guid = %d
        ORDER BY ci.bag ASC, ci.slot ASC
    ]], characterGuid)
    
    local inventoryResult = CharDBQuery(inventoryQuery)
    local inventoryData = {}
    local foundBagIds = {}
    local bagIdToInfo = {}
    
    if inventoryResult then
        repeat
            local bagId = inventoryResult:GetUInt32(0)
            local slotId = inventoryResult:GetUInt32(1)
            
            -- Track all unique bag IDs and map them to bag info
            if not foundBagIds[bagId] then
                foundBagIds[bagId] = 0
                
                -- Map this bag ID to its actual bag info
                if bagId > 0 and bagId ~= 255 then
                    if bagMapping[bagId] then
                        bagIdToInfo[bagId] = bagMapping[bagId]
                        print(string.format("[PlayerInventoryDataHandlers] Bag ID %d is bag item: %s", 
                            bagId, bagMapping[bagId].name))
                    else
                        print(string.format("[PlayerInventoryDataHandlers] Unknown bag ID %d found", bagId))
                    end
                end
            end
            foundBagIds[bagId] = foundBagIds[bagId] + 1
            
            local itemGuid = inventoryResult:GetUInt32(2)
            local itemEntry = inventoryResult:GetUInt32(3)
            local itemCount = inventoryResult:GetUInt32(4)
            local ownerGuid = inventoryResult:GetUInt32(5)
            local enchantmentsStr = inventoryResult:GetString(6)
            
            -- Get item info from world database
            local itemName = "Unknown Item"
            local itemQuality = 0
            local displayId = 0
            local itemClass = 0
            local inventoryType = 0
            
            if itemEntry > 0 then
                local itemInfoQuery = WorldDBQuery(string.format(
                    "SELECT name, Quality, displayid, class, InventoryType FROM item_template WHERE entry = %d",
                    itemEntry
                ))
                
                if itemInfoQuery then
                    itemName = itemInfoQuery:GetString(0) or "Unknown Item"
                    itemQuality = itemInfoQuery:GetUInt32(1) or 0
                    displayId = itemInfoQuery:GetUInt32(2) or 0
                    itemClass = itemInfoQuery:GetUInt32(3) or 0
                    inventoryType = itemInfoQuery:GetUInt32(4) or 0
                end
            end
            
            -- Determine if item is equipable
            local equipable = inventoryType > 0 and inventoryType ~= 18  -- Not a bag
            
            -- Parse enchantments
            local enchantId = 0
            if enchantmentsStr and enchantmentsStr ~= "" then
                local enchants = {}
                for value in string.gmatch(enchantmentsStr, "%S+") do
                    table.insert(enchants, tonumber(value) or 0)
                end
                enchantId = enchants[1] or 0
            end
            
            -- Debug prints
            if Config.debug then
                if bagId >= 19 and bagId <= 22 then
                    print(string.format("[PlayerInventoryDataHandlers] Equipped bag item: %s at bag %d, slot %d", 
                        itemName, bagId, slotId))
                elseif bagId >= 67 and bagId <= 73 then
                    print(string.format("[PlayerInventoryDataHandlers] Bank bag item: %s at bag %d, slot %d", 
                        itemName, bagId, slotId))
                end
            end
            
            if enchantId and enchantId > 0 then
                print(string.format("[PlayerInventoryDataHandlers] Found enchanted inventory item: %s (ID: %d) at bag %d, slot %d with enchantId: %d", 
                    itemName, itemEntry, bagId, slotId, enchantId))
            end
            
            -- Filter bag 0 items: only include actual backpack slots (23-38)
            -- Skip equipment (0-18), equipped bags (19-22), bank slots (39-66), and bank bags (67-74)
            local includeItem = true
            if bagId == 0 then
                -- For bag 0, only include actual backpack inventory slots (23-38)
                if slotId < 23 or slotId > 38 then
                    includeItem = false
                    print(string.format("[PlayerInventoryDataHandlers] Skipping bag 0 slot %d (not backpack slot)", slotId))
                else
                    print(string.format("[PlayerInventoryDataHandlers] Including backpack slot %d: %s (ID: %d, Bag: %d)", 
                        slotId, itemName, itemEntry, bagId))
                end
            end
            
            if includeItem then
                table.insert(inventoryData, {
                    bag = bagId,
                    slot = slotId,
                    entry = itemEntry,
                    count = itemCount,
                    name = itemName,
                    quality = itemQuality,
                    displayId = displayId,
                    itemGuid = itemGuid,
                    ownerGuid = ownerGuid,
                    class = itemClass,
                    inventoryType = inventoryType,
                    equipable = equipable,
                    enchantId = enchantId
                })
            end
        until not inventoryResult:NextRow()
    end
    
    return inventoryData, foundBagIds, bagIdToInfo
end

-- Get bank data from character_inventory (main bank slots 39-66 from bag 0)
function PlayerInventoryDataHandlers.getBankData(characterGuid)
    local bankQuery = string.format([[
        SELECT 
            ci.bag,
            ci.slot,
            ci.item,
            ii.itemEntry,
            ii.count,
            ii.owner_guid,
            ii.enchantments
        FROM character_inventory ci
        JOIN item_instance ii ON ci.item = ii.guid
        WHERE ci.guid = %d
        AND ci.bag = 0
        AND ci.slot >= 39 AND ci.slot <= 66
        ORDER BY ci.slot ASC
    ]], characterGuid)
    
    local bankResult = CharDBQuery(bankQuery)
    local bankData = {}
    
    if bankResult then
        repeat
            local bagId = bankResult:GetUInt32(0)
            local slotId = bankResult:GetUInt32(1)
            local itemGuid = bankResult:GetUInt32(2)
            local itemEntry = bankResult:GetUInt32(3)
            local itemCount = bankResult:GetUInt32(4)
            local ownerGuid = bankResult:GetUInt32(5)
            local enchantmentsStr = bankResult:GetString(6)
            
            -- Get item info from world database
            local itemName = "Unknown Item"
            local itemQuality = 0
            local displayId = 0
            local itemClass = 0
            local inventoryType = 0
            
            if itemEntry > 0 then
                local itemInfoQuery = WorldDBQuery(string.format(
                    "SELECT name, Quality, displayid, class, InventoryType FROM item_template WHERE entry = %d",
                    itemEntry
                ))
                
                if itemInfoQuery then
                    itemName = itemInfoQuery:GetString(0) or "Unknown Item"
                    itemQuality = itemInfoQuery:GetUInt32(1) or 0
                    displayId = itemInfoQuery:GetUInt32(2) or 0
                    itemClass = itemInfoQuery:GetUInt32(3) or 0
                    inventoryType = itemInfoQuery:GetUInt32(4) or 0
                end
            end
            
            -- Determine if item is equipable
            local equipable = inventoryType > 0 and inventoryType ~= 18  -- Not a bag
            
            -- Parse enchantments
            local enchantId = 0
            if enchantmentsStr and enchantmentsStr ~= "" then
                local enchants = {}
                for value in string.gmatch(enchantmentsStr, "%S+") do
                    table.insert(enchants, tonumber(value) or 0)
                end
                enchantId = enchants[1] or 0
            end
            
            if Config.debug then
                print(string.format("[PlayerInventoryDataHandlers] Bank slot %d: %s", slotId, itemName))
            end
            
            table.insert(bankData, {
                bag = 0,  -- Bank items are in bag 0 but will be displayed as virtual bag -1
                slot = slotId,
                entry = itemEntry,
                count = itemCount,
                name = itemName,
                quality = itemQuality,
                displayId = displayId,
                itemGuid = itemGuid,
                ownerGuid = ownerGuid,
                class = itemClass,
                inventoryType = inventoryType,
                equipable = equipable,
                enchantId = enchantId
            })
        until not bankResult:NextRow()
    end
    
    print(string.format("[PlayerInventoryDataHandlers] Found %d bank items", #bankData))
    return bankData
end

-- Get equipment data for a player
function PlayerInventoryDataHandlers.getEquipmentData(targetName, characterGuid)
    local equipmentData = {}
    local targetPlayer = GetPlayerByName(targetName)
    
    if targetPlayer then
        -- Player is online, use direct API
        print(string.format("[PlayerInventoryDataHandlers] Player %s is online, using GetEquippedItemBySlot", targetName))
        
        for slot = 0, 18 do
            local item = targetPlayer:GetEquippedItemBySlot(slot)
            if item then
                local itemEntry = item:GetEntry()
                local itemName = item:GetName()
                local itemQuality = item:GetQuality()
                local displayId = item:GetDisplayId()
                
                -- Get item class from database
                local itemClass = 0
                local itemClassQuery = WorldDBQuery(string.format(
                    "SELECT class FROM item_template WHERE entry = %d",
                    itemEntry
                ))
                if itemClassQuery then
                    itemClass = itemClassQuery:GetUInt32(0) or 0
                end
                
                -- Get enchantment data
                local enchantId = 0
                local itemGuid = item:GetGUIDLow()
                if itemGuid then
                    local enchantQuery = CharDBQuery(string.format(
                        "SELECT enchantments FROM item_instance WHERE guid = %d",
                        itemGuid
                    ))
                    if enchantQuery then
                        local enchantmentsStr = enchantQuery:GetString(0)
                        if enchantmentsStr and enchantmentsStr ~= "" then
                            local firstSpace = string.find(enchantmentsStr, " ")
                            if firstSpace then
                                enchantId = tonumber(string.sub(enchantmentsStr, 1, firstSpace - 1)) or 0
                            else
                                enchantId = tonumber(enchantmentsStr) or 0
                            end
                        end
                    end
                end
                
                equipmentData[slot] = {
                    entry = itemEntry,
                    count = 1,
                    name = itemName,
                    quality = itemQuality,
                    displayId = displayId,
                    class = itemClass,
                    enchantId = enchantId
                }
                
                print(string.format("[PlayerInventoryDataHandlers] Slot %d (%s): %s (ID: %d)", 
                    slot, Utils.slotNames[slot] or "Unknown", itemName, itemEntry))
            end
        end
    else
        -- Player is offline, query database
        print(string.format("[PlayerInventoryDataHandlers] Player %s is offline, using database query", targetName))
        
        local equippedQuery = string.format([[
            SELECT 
                ci.slot,
                ii.itemEntry,
                ii.count,
                ii.enchantments
            FROM character_inventory ci
            JOIN item_instance ii ON ci.item = ii.guid
            WHERE ci.guid = %d AND ci.bag = 255
        ]], characterGuid)
        
        local equippedResult = CharDBQuery(equippedQuery)
        
        if equippedResult then
            repeat
                local slot = equippedResult:GetUInt32(0)
                local itemEntry = equippedResult:GetUInt32(1)
                local itemCount = equippedResult:GetUInt32(2)
                local enchantmentsStr = equippedResult:GetString(3)
                
                -- Parse enchantments
                local enchantId = 0
                if enchantmentsStr and enchantmentsStr ~= "" then
                    local firstSpace = string.find(enchantmentsStr, " ")
                    if firstSpace then
                        enchantId = tonumber(string.sub(enchantmentsStr, 1, firstSpace - 1)) or 0
                    else
                        enchantId = tonumber(enchantmentsStr) or 0
                    end
                end
                
                -- Get item info
                local itemName = "Unknown Item"
                local itemQuality = 0
                local displayId = 0
                local itemClass = 0
                
                if itemEntry > 0 then
                    local itemInfoQuery = WorldDBQuery(string.format(
                        "SELECT name, Quality, displayid, class FROM item_template WHERE entry = %d",
                        itemEntry
                    ))
                    
                    if itemInfoQuery then
                        itemName = itemInfoQuery:GetString(0) or "Unknown Item"
                        itemQuality = itemInfoQuery:GetUInt32(1) or 0
                        displayId = itemInfoQuery:GetUInt32(2) or 0
                        itemClass = itemInfoQuery:GetUInt32(3) or 0
                    end
                end
                
                if slot <= 18 then  -- Only equipment slots 0-18
                    equipmentData[slot] = {
                        entry = itemEntry,
                        count = itemCount,
                        name = itemName,
                        quality = itemQuality,
                        displayId = displayId,
                        class = itemClass,
                        enchantId = enchantId
                    }
                    
                    print(string.format("[PlayerInventoryDataHandlers] Slot %d (%s): %s (ID: %d)", 
                        slot, Utils.slotNames[slot] or "Unknown", itemName, itemEntry))
                end
            until not equippedResult:NextRow()
        end
    end
    
    return equipmentData
end

-- Get bag sizes for a player
function PlayerInventoryDataHandlers.getBagSizes(targetName, characterGuid, bagMapping, bagItemToSlot, inventoryData, foundBagIds)
    local bagSizes = {}
    bagSizes[0] = 16  -- Backpack is always 16 slots
    
    local targetPlayer = GetPlayerByName(targetName)
    
    if targetPlayer then
        -- Player is online, get actual bag sizes
        for bagSlot = 19, 22 do
            local bag = targetPlayer:GetItemByPos(0, bagSlot)
            if bag then
                local bagGuid = bag:GetGUIDLow()
                local bagEntry = bag:GetEntry()
                local bagName = bag:GetName()
                
                local bagInfoQuery = WorldDBQuery(string.format(
                    "SELECT ContainerSlots FROM item_template WHERE entry = %d AND class = 1",
                    bagEntry
                ))
                
                if bagInfoQuery then
                    local containerSlots = bagInfoQuery:GetUInt32(0)
                    bagSizes[bagSlot] = containerSlots
                    
                    bagMapping[bagGuid] = {
                        slot = bagSlot,
                        itemEntry = bagEntry,
                        size = containerSlots,
                        name = bagName,
                        type = "regular",
                        entry = bagEntry
                    }
                    bagItemToSlot[bagGuid] = bagSlot
                    
                    print(string.format("[PlayerInventoryDataHandlers] Online player bag: %s (GUID: %d) at slot %d with %d slots", 
                        bagName, bagGuid, bagSlot, containerSlots))
                else
                    bagSizes[bagSlot] = 0
                end
            else
                bagSizes[bagSlot] = 0
            end
        end
        
        -- Get bank bags for online player
        for bankSlot = 67, 73 do
            local bankBag = targetPlayer:GetItemByPos(0, bankSlot)
            if bankBag then
                local bagGuid = bankBag:GetGUIDLow()
                local bagEntry = bankBag:GetEntry()
                local bagName = bankBag:GetName()
                
                local bagInfoQuery = WorldDBQuery(string.format(
                    "SELECT ContainerSlots FROM item_template WHERE entry = %d AND class = 1",
                    bagEntry
                ))
                
                if bagInfoQuery then
                    local containerSlots = bagInfoQuery:GetUInt32(0)
                    
                    bagMapping[bagGuid] = {
                        slot = bankSlot,
                        itemEntry = bagEntry,
                        size = containerSlots,
                        name = bagName,
                        type = "bank",
                        entry = bagEntry
                    }
                    bagItemToSlot[bagGuid] = bankSlot
                    
                    print(string.format("[PlayerInventoryDataHandlers] Online player bank bag: %s (GUID: %d) at slot %d with %d slots", 
                        bagName, bagGuid, bankSlot, containerSlots))
                end
            end
        end
    else
        -- Player is offline, get bag sizes from database
        print("[PlayerInventoryDataHandlers] Player offline, checking database for bag sizes")
        local bagQuery = CharDBQuery(string.format([[
            SELECT 
                ci.slot,
                ii.itemEntry
            FROM character_inventory ci
            JOIN item_instance ii ON ci.item = ii.guid
            WHERE ci.guid = %d AND ci.bag = 255 AND ci.slot >= 19 AND ci.slot <= 22
        ]], characterGuid))
        
        if bagQuery then
            repeat
                local slot = bagQuery:GetUInt32(0)
                local itemEntry = bagQuery:GetUInt32(1)
                
                local containerQuery = WorldDBQuery(string.format(
                    "SELECT ContainerSlots FROM item_template WHERE entry = %d AND class = 1",
                    itemEntry
                ))
                
                if containerQuery then
                    local containerSlots = containerQuery:GetUInt32(0)
                    bagSizes[slot] = containerSlots
                    print(string.format("[PlayerInventoryDataHandlers] Bag slot %d (item %d) has size: %d", slot, itemEntry, containerSlots))
                else
                    bagSizes[slot] = 0
                end
            until not bagQuery:NextRow()
        end
        
        for bagSlot = 19, 22 do
            if not bagSizes[bagSlot] then
                bagSizes[bagSlot] = 0
            end
        end
    end
    
    -- Add bank bag sizes if we have bank items
    for _, item in ipairs(inventoryData) do
        if item.bag >= 67 and item.bag <= 73 then
            if not bagSizes[item.bag] then
                bagSizes[item.bag] = 28  -- Default bank bag size
            end
        end
    end
    
    -- Check for non-standard bag IDs and map them
    for bagId, count in pairs(foundBagIds) do
        if bagId >= 35 and bagId <= 38 then
            local standardSlot = bagId - 35 + 19
            if not bagSizes[standardSlot] or bagSizes[standardSlot] == 0 then
                bagSizes[standardSlot] = 16
                print(string.format("[PlayerInventoryDataHandlers] Mapping bag %d to slot %d with default size 16", 
                    bagId, standardSlot))
            end
        elseif bagId >= 23 and bagId <= 26 then
            local standardSlot = bagId - 23 + 19
            if not bagSizes[standardSlot] or bagSizes[standardSlot] == 0 then
                bagSizes[standardSlot] = 16
                print(string.format("[PlayerInventoryDataHandlers] Mapping bag %d to slot %d with default size 16", 
                    bagId, standardSlot))
            end
        end
    end
    
    return bagSizes
end

-- Create bag configuration for client
function PlayerInventoryDataHandlers.createBagConfiguration(bagSizes, bagIdToInfo)
    local bagConfiguration = {
        bagMapping = {},
        bagSizes = bagSizes,
    }
    
    -- Build complete bag mapping for client
    for bagId, info in pairs(bagIdToInfo) do
        bagConfiguration.bagMapping[bagId] = {
            slot = info.slot,
            size = info.size,
            type = info.type,
            name = info.name,
            entry = info.entry
        }
    end
    
    -- Add special bags
    bagConfiguration.bagMapping[0] = { slot = 0, size = 16, type = "backpack", name = "Backpack" }
    bagConfiguration.bagMapping[255] = { slot = 255, size = 0, type = "equipment", name = "Equipment" }
    bagConfiguration.bagMapping[-1] = { slot = -1, size = 28, type = "bank_main", name = "Bank" }
    
    print("[PlayerInventoryDataHandlers] Bag configuration includes:")
    for bagId, info in pairs(bagConfiguration.bagMapping) do
        print(string.format("  Bag %d: %s (type: %s, size: %d)", 
            bagId, info.name, info.type, info.size))
    end
    
    return bagConfiguration
end

-- Get player stats (health, mana, attributes, etc.)
function PlayerInventoryDataHandlers.getPlayerStats(targetName, characterGuid)
    local stats = {}
    
    -- Try to get stats from online player first (most accurate)
    local targetPlayer = GetPlayerByName(targetName)
    if targetPlayer then
        -- Get primary stats
        stats.strength = targetPlayer:GetStat(0)  -- STAT_STRENGTH
        stats.agility = targetPlayer:GetStat(1)   -- STAT_AGILITY
        stats.stamina = targetPlayer:GetStat(2)   -- STAT_STAMINA
        stats.intellect = targetPlayer:GetStat(3) -- STAT_INTELLECT
        stats.spirit = targetPlayer:GetStat(4)    -- STAT_SPIRIT
        
        -- Get health and power
        stats.health = targetPlayer:GetHealth()
        stats.maxHealth = targetPlayer:GetMaxHealth()
        stats.powerType = targetPlayer:GetPowerType()
        stats.power = targetPlayer:GetPower(stats.powerType)
        stats.maxPower = targetPlayer:GetMaxPower(stats.powerType)
        
        -- Get level and class info
        stats.level = targetPlayer:GetLevel()
        stats.class = targetPlayer:GetClass()
        stats.race = targetPlayer:GetRace()
        stats.gender = targetPlayer:GetGender()
        
        -- Get currency
        stats.money = targetPlayer:GetCoinage()
        stats.arenaPoints = targetPlayer:GetArenaPoints()
        stats.honorPoints = targetPlayer:GetHonorPoints()
        
        -- Get additional useful stats
        stats.totalPlayTime = targetPlayer:GetTotalPlayedTime()
        stats.levelPlayTime = targetPlayer:GetLevelPlayedTime()
    else
        -- Fall back to database values if player is offline
        local statsQuery = CharDBQuery(string.format([[
            SELECT 
                level, class, race, gender, money, 
                arenaPoints, totalHonorPoints,
                health, 
                CASE 
                    WHEN class IN (1,2,6) THEN 1  -- Warrior, Paladin, DK use rage/runic
                    WHEN class = 3 THEN 2         -- Hunter uses focus (in 3.3.5 still mana)
                    WHEN class = 4 THEN 3         -- Rogue uses energy
                    ELSE 0                         -- Others use mana
                END as powerType,
                power1, power2, power3, power4, power5, power6, power7,
                totaltime, leveltime
            FROM characters 
            WHERE guid = %d
        ]], characterGuid))
        
        if statsQuery then
            stats.level = statsQuery:GetUInt32(0)
            stats.class = statsQuery:GetUInt32(1)
            stats.race = statsQuery:GetUInt32(2)
            stats.gender = statsQuery:GetUInt32(3)
            stats.money = statsQuery:GetUInt32(4)
            stats.arenaPoints = statsQuery:GetUInt32(5)
            stats.honorPoints = statsQuery:GetUInt32(6)
            stats.health = statsQuery:GetUInt32(7)
            stats.powerType = statsQuery:GetUInt32(8)
            
            -- Get the appropriate power value based on type
            local powerIndex = stats.powerType + 1  -- power1 is at index 9, power2 at 10, etc.
            if powerIndex >= 1 and powerIndex <= 7 then
                stats.power = statsQuery:GetUInt32(8 + powerIndex)
            else
                stats.power = statsQuery:GetUInt32(9)  -- Default to power1 (mana)
            end
            
            stats.totalPlayTime = statsQuery:GetUInt32(16)
            stats.levelPlayTime = statsQuery:GetUInt32(17)
            
            -- For offline players, we can't get exact current stats, so estimate
            -- These would need formulas based on level, class, and race
            stats.strength = 20 + (stats.level * 2)  -- Basic estimation
            stats.agility = 20 + (stats.level * 2)
            stats.stamina = 20 + (stats.level * 2)
            stats.intellect = 20 + (stats.level * 2)
            stats.spirit = 20 + (stats.level * 2)
            
            -- Estimate max values based on power type
            stats.maxHealth = stats.health  -- Assume full health when offline
            
            -- Set proper max values for different power types
            if stats.powerType == 0 then  -- Mana
                stats.maxPower = 1000 + (stats.level * 20)
            elseif stats.powerType == 1 then  -- Rage
                stats.maxPower = 100
            elseif stats.powerType == 3 then  -- Energy
                stats.maxPower = 100
            elseif stats.powerType == 6 then  -- Runic Power
                stats.maxPower = 100
            else
                stats.maxPower = 100  -- Default for other types
            end
        end
    end
    
    -- Add power type name for client display
    local powerTypeNames = {
        [0] = "Mana",
        [1] = "Rage", 
        [2] = "Focus",
        [3] = "Energy",
        [4] = "Happiness",
        [5] = "Rune",
        [6] = "Runic Power"
    }
    stats.powerTypeName = powerTypeNames[stats.powerType] or "Unknown"
    
    -- Calculate additional combat stats
    if targetPlayer then
        -- Melee stats (for online players)
        -- Attack power calculation (rough approximation for 3.3.5)
        if stats.class == 1 or stats.class == 2 or stats.class == 6 then -- Warrior, Paladin, DK
            stats.attackPower = stats.strength * 2
        elseif stats.class == 3 or stats.class == 4 then -- Hunter, Rogue
            stats.attackPower = stats.strength + stats.agility
        else
            stats.attackPower = stats.strength * 2
        end
        
        -- Try to get spell power (may not work on all servers)
        stats.spellPower = 0
        local getSpellPower = targetPlayer.GetBaseSpellPower
        if getSpellPower then
            stats.spellPower = getSpellPower(targetPlayer, 0) or 0 -- Arcane school
        end
        
        -- If no spell power method, estimate from intellect
        if stats.spellPower == 0 then
            stats.spellPower = math.floor(stats.intellect * 0.8) -- Rough estimate
        end
        
        -- Armor (if method exists)
        stats.armor = 0
        local getArmor = targetPlayer.GetArmor
        if getArmor then
            stats.armor = getArmor(targetPlayer) or 0
        end
        
        -- Block value for tank classes
        stats.blockValue = 0
        if stats.class == 1 or stats.class == 2 then -- Warrior or Paladin
            local getBlock = targetPlayer.GetShieldBlockValue
            if getBlock then
                stats.blockValue = getBlock(targetPlayer) or 0
            end
        end
    else
        -- Offline player estimations
        -- Attack power
        if stats.class == 1 or stats.class == 2 or stats.class == 6 then
            stats.attackPower = stats.strength * 2
        elseif stats.class == 3 or stats.class == 4 then
            stats.attackPower = stats.strength + stats.agility
        else
            stats.attackPower = stats.strength * 2
        end
        
        -- Spell power estimation
        stats.spellPower = math.floor(stats.intellect * 0.8)
        
        -- Basic armor estimation (very rough)
        stats.armor = 100 + (stats.agility * 2) + (stats.level * 50)
        
        -- Block value
        stats.blockValue = 0
        if stats.class == 1 or stats.class == 2 then
            stats.blockValue = 30 + (stats.strength / 2)
        end
    end
    
    -- Calculate crit chances (rough formulas for 3.3.5)
    -- Base crit is 5% for most classes
    local baseCrit = 5.0
    
    -- Ensure we have valid stats before calculations
    stats.level = stats.level or 1
    stats.agility = stats.agility or 20
    stats.intellect = stats.intellect or 20
    stats.spirit = stats.spirit or 20
    stats.strength = stats.strength or 20
    stats.stamina = stats.stamina or 20
    
    -- Melee crit from agility (varies by class and level)
    local agiPerCrit = 20 -- Rough average at level 80
    if stats.level < 80 then
        agiPerCrit = 20 * (80 / math.max(1, stats.level)) -- Scale for lower levels
    end
    stats.meleeCrit = baseCrit + (stats.agility / agiPerCrit)
    
    -- Spell crit from intellect
    local intPerCrit = 80 -- Rough average at level 80
    if stats.level < 80 then
        intPerCrit = 80 * (80 / math.max(1, stats.level))
    end
    stats.spellCrit = baseCrit + (stats.intellect / intPerCrit)
    
    -- Haste (we can't get this accurately, so set to 0)
    stats.meleeHaste = 0
    stats.spellHaste = 0
    
    -- Hit rating (we can't get this accurately, so set to 0)
    stats.meleeHit = 0
    stats.spellHit = 0
    
    -- Expertise (melee only, can't get accurately)
    stats.expertise = 0
    
    -- Mana regen from spirit (rough formula)
    stats.mp5 = math.floor(stats.spirit * 0.2) -- Very rough estimate
    
    -- Defense rating (can't get accurately, estimate for tanks)
    stats.defense = 0
    if stats.class == 1 or stats.class == 2 or stats.class == 6 then
        stats.defense = 400 + ((stats.level or 1) * 5) -- Base defense skill
    end
    
    -- Dodge/Parry/Block chances (very rough estimates)
    if stats.class == 1 or stats.class == 2 or stats.class == 6 then -- Tank classes
        stats.dodgeChance = 5.0 + ((stats.agility or 20) / 25)
        stats.parryChance = 5.0
        stats.blockChance = 5.0 + ((stats.defense or 0) / 25) -- where defense is rating
    elseif stats.class == 4 then -- Rogue
        stats.dodgeChance = 5.0 + ((stats.agility or 20) / 20)
        stats.parryChance = 0
        stats.blockChance = 0
    else
        stats.dodgeChance = 5.0 + ((stats.agility or 20) / 30)
        stats.parryChance = 0
        stats.blockChance = 0
    end
    
    -- Add class name for display
    local classNames = {
        [1] = "Warrior",
        [2] = "Paladin",
        [3] = "Hunter",
        [4] = "Rogue",
        [5] = "Priest",
        [6] = "Death Knight",
        [7] = "Shaman",
        [8] = "Mage",
        [9] = "Warlock",
        [11] = "Druid"
    }
    stats.className = classNames[stats.class] or "Unknown"
    
    -- Add race name for display
    local raceNames = {
        [1] = "Human",
        [2] = "Orc",
        [3] = "Dwarf",
        [4] = "Night Elf",
        [5] = "Undead",
        [6] = "Tauren",
        [7] = "Gnome",
        [8] = "Troll",
        [10] = "Blood Elf",
        [11] = "Draenei"
    }
    stats.raceName = raceNames[stats.race] or "Unknown"
    
    return stats
end

return PlayerInventoryDataHandlers