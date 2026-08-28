local PlayerInventoryBankHandlers = {}

local Config

function PlayerInventoryBankHandlers.init(config)
    Config = config
end

function PlayerInventoryBankHandlers.getBankData(characterGuid)
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

    if not bankResult then
        return bankData
    end

    local rawBankData = {}
    local uniqueItemEntries = {}

    repeat
        local bagId = bankResult:GetUInt32(0)
        local slotId = bankResult:GetUInt32(1)
        local itemGuid = bankResult:GetUInt32(2)
        local itemEntry = bankResult:GetUInt32(3)
        local itemCount = bankResult:GetUInt32(4)
        local ownerGuid = bankResult:GetUInt32(5)
        local enchantmentsStr = bankResult:GetString(6)

        table.insert(rawBankData, {
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
    until not bankResult:NextRow()

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

    for _, item in ipairs(rawBankData) do
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

        local enchantId = 0
        if item.enchantmentsStr and item.enchantmentsStr ~= "" then
            local enchants = {}
            for value in string.gmatch(item.enchantmentsStr, "%S+") do
                table.insert(enchants, tonumber(value) or 0)
            end
            enchantId = enchants[1] or 0
        end

        if Config.debug then
            print(string.format("[PlayerInventoryDataHandlers] Bank slot %d: %s", slotId, itemName))
        end

        table.insert(bankData, {
            bag = 0,
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

    return bankData
end

return PlayerInventoryBankHandlers
