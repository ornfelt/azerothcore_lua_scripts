local PlayerInventoryDataHandlers = {}

local BankHandlers = require("GameMasterUI.Server.Handlers.Player.Inventory.PlayerInventoryBankHandlers")
local BagMapping = require("GameMasterUI.Server.Handlers.Player.Inventory.PlayerInventoryBagMapping")

local function parseFirstEnchantId(enchantmentsStr)
    if not enchantmentsStr or enchantmentsStr == "" then return 0 end
    local firstSpace = string.find(enchantmentsStr, " ")
    if firstSpace then
        return tonumber(string.sub(enchantmentsStr, 1, firstSpace - 1)) or 0
    end
    return tonumber(enchantmentsStr) or 0
end

local GameMasterSystem, Config, Utils, Database, DatabaseHelper

function PlayerInventoryDataHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper

    BankHandlers.init(config)

    GameMasterSystem._queryAndSendInventory = PlayerInventoryDataHandlers.queryAndSendInventory
end

function PlayerInventoryDataHandlers.queryAndSendInventory(player, targetName)
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

    local bagMapping, bagItemToSlot = BagMapping.getBagMapping(characterGuid, targetName)
    local inventoryData, foundBagIds, bagIdToInfo = PlayerInventoryDataHandlers.getInventoryData(characterGuid, bagMapping)
    local bankData = BankHandlers.getBankData(characterGuid)
    local equipmentData, equipmentCount = PlayerInventoryDataHandlers.getEquipmentData(targetName, characterGuid)
    local bagSizes = BagMapping.getBagSizes(targetName, characterGuid, bagMapping, bagItemToSlot, inventoryData, foundBagIds)
    local bagConfiguration = BagMapping.createBagConfiguration(bagSizes, bagIdToInfo)
    local playerStats = PlayerInventoryDataHandlers.getPlayerStats(targetName, characterGuid)

    Utils.sendMessage(player, "success", string.format("Loaded inventory for %s (%d items, %d equipped, %d bank)",
        targetName, #inventoryData, equipmentCount, #bankData))

    AIO.Handle(player, "GameMasterSystem", "receiveInventoryData", inventoryData, equipmentData, targetName, bagConfiguration, bankData, playerStats)
end

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

    if not inventoryResult then
        return inventoryData, foundBagIds, bagIdToInfo
    end

    local rawInventoryData = {}
    local uniqueItemEntries = {}

    repeat
        local bagId = inventoryResult:GetUInt32(0)
        local slotId = inventoryResult:GetUInt32(1)
        local itemGuid = inventoryResult:GetUInt32(2)
        local itemEntry = inventoryResult:GetUInt32(3)
        local itemCount = inventoryResult:GetUInt32(4)
        local ownerGuid = inventoryResult:GetUInt32(5)
        local enchantmentsStr = inventoryResult:GetString(6)

        if not foundBagIds[bagId] then
            foundBagIds[bagId] = 0

            if bagId > 0 and bagId ~= 255 then
                if bagMapping[bagId] then
                    bagIdToInfo[bagId] = bagMapping[bagId]
                end
            end
        end
        foundBagIds[bagId] = foundBagIds[bagId] + 1

        table.insert(rawInventoryData, {
            bagId = bagId,
            slotId = slotId,
            itemGuid = itemGuid,
            itemEntry = itemEntry,
            itemCount = itemCount,
            ownerGuid = ownerGuid,
            enchantmentsStr = enchantmentsStr
        })

        if itemEntry > 0 then
            uniqueItemEntries[itemEntry] = true
        end
    until not inventoryResult:NextRow()

    local itemTemplateData = {}
    if next(uniqueItemEntries) then
        local entryList = {}
        for entry, _ in pairs(uniqueItemEntries) do
            table.insert(entryList, entry)
        end

        local batchItemQuery = string.format(
            "SELECT entry, name, Quality, displayid, class, InventoryType FROM item_template WHERE entry IN (%s)",
            table.concat(entryList, ",")
        )

        local batchResult = WorldDBQuery(batchItemQuery)
        if batchResult then
            repeat
                local entry = batchResult:GetUInt32(0)
                itemTemplateData[entry] = {
                    name = batchResult:GetString(1) or "Unknown Item",
                    quality = batchResult:GetUInt32(2) or 0,
                    displayId = batchResult:GetUInt32(3) or 0,
                    class = batchResult:GetUInt32(4) or 0,
                    inventoryType = batchResult:GetUInt32(5) or 0
                }
            until not batchResult:NextRow()
        end
    end

    for _, item in ipairs(rawInventoryData) do
        local bagId = item.bagId
        local slotId = item.slotId
        local itemEntry = item.itemEntry

        local itemName = "Unknown Item"
        local itemQuality = 0
        local displayId = 0
        local itemClass = 0
        local inventoryType = 0

        if itemEntry > 0 and itemTemplateData[itemEntry] then
            local templateInfo = itemTemplateData[itemEntry]
            itemName = templateInfo.name
            itemQuality = templateInfo.quality
            displayId = templateInfo.displayId
            itemClass = templateInfo.class
            inventoryType = templateInfo.inventoryType
        end

        local equipable = inventoryType > 0 and inventoryType ~= 18

        local enchantId = parseFirstEnchantId(item.enchantmentsStr)

        local includeItem = true
        if bagId == 0 then
            if slotId < 23 or slotId > 38 then
                includeItem = false
            end
        end

        if includeItem then
            table.insert(inventoryData, {
                bag = bagId,
                slot = slotId,
                entry = itemEntry,
                count = item.itemCount,
                name = itemName,
                quality = itemQuality,
                displayId = displayId,
                itemGuid = item.itemGuid,
                ownerGuid = item.ownerGuid,
                class = itemClass,
                inventoryType = inventoryType,
                equipable = equipable,
                enchantId = enchantId
            })
        end
    end

    return inventoryData, foundBagIds, bagIdToInfo
end

function PlayerInventoryDataHandlers.getEquipmentData(targetName, characterGuid)
    local equipmentData = {}
    local equipmentCount = 0
    local targetPlayer = GetPlayerByName(targetName)

    if targetPlayer then
        local slotItems = {}
        local entrySet = {}
        local guidSet = {}

        for slot = 0, 18 do
            local item = targetPlayer:GetEquippedItemBySlot(slot)
            if item then
                local entry = item:GetEntry()
                local guidLow = item:GetGUIDLow()
                slotItems[slot] = {
                    entry = entry,
                    name = item:GetName(),
                    quality = item:GetQuality(),
                    displayId = item:GetDisplayId(),
                    guidLow = guidLow
                }
                entrySet[entry] = true
                if guidLow then
                    guidSet[guidLow] = true
                end
            end
        end

        local classMap = {}
        if next(entrySet) then
            local entryList = {}
            for entry in pairs(entrySet) do
                table.insert(entryList, entry)
            end
            local classResult = WorldDBQuery(string.format(
                "SELECT entry, class FROM item_template WHERE entry IN (%s)",
                table.concat(entryList, ",")
            ))
            if classResult then
                repeat
                    classMap[classResult:GetUInt32(0)] = classResult:GetUInt32(1) or 0
                until not classResult:NextRow()
            end
        end

        local enchantMap = {}
        if next(guidSet) then
            local guidList = {}
            for guid in pairs(guidSet) do
                table.insert(guidList, guid)
            end
            local enchantResult = CharDBQuery(string.format(
                "SELECT guid, enchantments FROM item_instance WHERE guid IN (%s)",
                table.concat(guidList, ",")
            ))
            if enchantResult then
                repeat
                    enchantMap[enchantResult:GetUInt32(0)] = enchantResult:GetString(1)
                until not enchantResult:NextRow()
            end
        end

        for slot, info in pairs(slotItems) do
            equipmentData[slot] = {
                entry = info.entry,
                count = 1,
                name = info.name,
                quality = info.quality,
                displayId = info.displayId,
                class = classMap[info.entry] or 0,
                enchantId = parseFirstEnchantId(enchantMap[info.guidLow])
            }
            equipmentCount = equipmentCount + 1
        end
    else
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
            local rawSlots = {}
            local entrySet = {}

            repeat
                local slot = equippedResult:GetUInt32(0)
                local itemEntry = equippedResult:GetUInt32(1)
                if slot <= 18 then
                    table.insert(rawSlots, {
                        slot = slot,
                        itemEntry = itemEntry,
                        itemCount = equippedResult:GetUInt32(2),
                        enchantId = parseFirstEnchantId(equippedResult:GetString(3))
                    })
                    if itemEntry > 0 then
                        entrySet[itemEntry] = true
                    end
                end
            until not equippedResult:NextRow()

            local templateData = {}
            if next(entrySet) then
                local entryList = {}
                for entry in pairs(entrySet) do
                    table.insert(entryList, entry)
                end
                local batchResult = WorldDBQuery(string.format(
                    "SELECT entry, name, Quality, displayid, class FROM item_template WHERE entry IN (%s)",
                    table.concat(entryList, ",")
                ))
                if batchResult then
                    repeat
                        templateData[batchResult:GetUInt32(0)] = {
                            name = batchResult:GetString(1) or "Unknown Item",
                            quality = batchResult:GetUInt32(2) or 0,
                            displayId = batchResult:GetUInt32(3) or 0,
                            class = batchResult:GetUInt32(4) or 0
                        }
                    until not batchResult:NextRow()
                end
            end

            for _, raw in ipairs(rawSlots) do
                local tmpl = templateData[raw.itemEntry]
                equipmentData[raw.slot] = {
                    entry = raw.itemEntry,
                    count = raw.itemCount,
                    name = tmpl and tmpl.name or "Unknown Item",
                    quality = tmpl and tmpl.quality or 0,
                    displayId = tmpl and tmpl.displayId or 0,
                    class = tmpl and tmpl.class or 0,
                    enchantId = raw.enchantId
                }
                equipmentCount = equipmentCount + 1
            end
        end
    end

    return equipmentData, equipmentCount
end

function PlayerInventoryDataHandlers.getPlayerStats(targetName, characterGuid)
    local stats = {}

    local targetPlayer = GetPlayerByName(targetName)
    if targetPlayer then
        stats.strength = targetPlayer:GetStat(0)
        stats.agility = targetPlayer:GetStat(1)
        stats.stamina = targetPlayer:GetStat(2)
        stats.intellect = targetPlayer:GetStat(3)
        stats.spirit = targetPlayer:GetStat(4)

        stats.health = targetPlayer:GetHealth()
        stats.maxHealth = targetPlayer:GetMaxHealth()
        stats.powerType = targetPlayer:GetPowerType()
        stats.power = targetPlayer:GetPower(stats.powerType)
        stats.maxPower = targetPlayer:GetMaxPower(stats.powerType)

        stats.level = targetPlayer:GetLevel()
        stats.class = targetPlayer:GetClass()
        stats.race = targetPlayer:GetRace()
        stats.gender = targetPlayer:GetGender()

        stats.money = targetPlayer:GetCoinage()
        stats.arenaPoints = targetPlayer:GetArenaPoints()
        stats.honorPoints = targetPlayer:GetHonorPoints()

        stats.totalPlayTime = targetPlayer:GetTotalPlayedTime()
        stats.levelPlayTime = targetPlayer:GetLevelPlayedTime()
    else
        local statsQuery = CharDBQuery(string.format([[
            SELECT
                level, class, race, gender, money,
                arenaPoints, totalHonorPoints,
                health,
                CASE
                    WHEN class IN (1,2,6) THEN 1
                    WHEN class = 3 THEN 2
                    WHEN class = 4 THEN 3
                    ELSE 0
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

            local powerIndex = stats.powerType + 1
            if powerIndex >= 1 and powerIndex <= 7 then
                stats.power = statsQuery:GetUInt32(8 + powerIndex)
            else
                stats.power = statsQuery:GetUInt32(9)
            end

            stats.totalPlayTime = statsQuery:GetUInt32(16)
            stats.levelPlayTime = statsQuery:GetUInt32(17)

            stats.strength = 20 + (stats.level * 2)
            stats.agility = 20 + (stats.level * 2)
            stats.stamina = 20 + (stats.level * 2)
            stats.intellect = 20 + (stats.level * 2)
            stats.spirit = 20 + (stats.level * 2)

            stats.maxHealth = stats.health

            if stats.powerType == 0 then
                stats.maxPower = 1000 + (stats.level * 20)
            elseif stats.powerType == 1 then
                stats.maxPower = 100
            elseif stats.powerType == 3 then
                stats.maxPower = 100
            elseif stats.powerType == 6 then
                stats.maxPower = 100
            else
                stats.maxPower = 100
            end
        end
    end

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

    if targetPlayer then
        if stats.class == 1 or stats.class == 2 or stats.class == 6 then
            stats.attackPower = stats.strength * 2
        elseif stats.class == 3 or stats.class == 4 then
            stats.attackPower = stats.strength + stats.agility
        else
            stats.attackPower = stats.strength * 2
        end

        stats.spellPower = 0
        local getSpellPower = targetPlayer.GetBaseSpellPower
        if getSpellPower then
            stats.spellPower = getSpellPower(targetPlayer, 0) or 0
        end

        if stats.spellPower == 0 then
            stats.spellPower = math.floor(stats.intellect * 0.8)
        end

        stats.armor = 0
        local getArmor = targetPlayer.GetArmor
        if getArmor then
            stats.armor = getArmor(targetPlayer) or 0
        end

        stats.blockValue = 0
        if stats.class == 1 or stats.class == 2 then
            local getBlock = targetPlayer.GetShieldBlockValue
            if getBlock then
                stats.blockValue = getBlock(targetPlayer) or 0
            end
        end
    else
        if stats.class == 1 or stats.class == 2 or stats.class == 6 then
            stats.attackPower = stats.strength * 2
        elseif stats.class == 3 or stats.class == 4 then
            stats.attackPower = stats.strength + stats.agility
        else
            stats.attackPower = stats.strength * 2
        end

        stats.spellPower = math.floor(stats.intellect * 0.8)
        stats.armor = 100 + (stats.agility * 2) + (stats.level * 50)

        stats.blockValue = 0
        if stats.class == 1 or stats.class == 2 then
            stats.blockValue = 30 + (stats.strength / 2)
        end
    end

    local baseCrit = 5.0

    stats.level = stats.level or 1
    stats.agility = stats.agility or 20
    stats.intellect = stats.intellect or 20
    stats.spirit = stats.spirit or 20
    stats.strength = stats.strength or 20
    stats.stamina = stats.stamina or 20

    local agiPerCrit = 20
    if stats.level < 80 then
        agiPerCrit = 20 * (80 / math.max(1, stats.level))
    end
    stats.meleeCrit = baseCrit + (stats.agility / agiPerCrit)

    local intPerCrit = 80
    if stats.level < 80 then
        intPerCrit = 80 * (80 / math.max(1, stats.level))
    end
    stats.spellCrit = baseCrit + (stats.intellect / intPerCrit)

    stats.meleeHaste = 0
    stats.spellHaste = 0
    stats.meleeHit = 0
    stats.spellHit = 0
    stats.expertise = 0
    stats.mp5 = math.floor(stats.spirit * 0.2)

    stats.defense = 0
    if stats.class == 1 or stats.class == 2 or stats.class == 6 then
        stats.defense = 400 + ((stats.level or 1) * 5)
    end

    if stats.class == 1 or stats.class == 2 or stats.class == 6 then
        stats.dodgeChance = 5.0 + ((stats.agility or 20) / 25)
        stats.parryChance = 5.0
        stats.blockChance = 5.0 + ((stats.defense or 0) / 25)
    elseif stats.class == 4 then
        stats.dodgeChance = 5.0 + ((stats.agility or 20) / 20)
        stats.parryChance = 0
        stats.blockChance = 0
    else
        stats.dodgeChance = 5.0 + ((stats.agility or 20) / 30)
        stats.parryChance = 0
        stats.blockChance = 0
    end

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

-- Re-export sub-module functions for backwards compatibility
PlayerInventoryDataHandlers.getBagMapping = BagMapping.getBagMapping
PlayerInventoryDataHandlers.getBagSizes = BagMapping.getBagSizes
PlayerInventoryDataHandlers.createBagConfiguration = BagMapping.createBagConfiguration
PlayerInventoryDataHandlers.getBankData = BankHandlers.getBankData

return PlayerInventoryDataHandlers
