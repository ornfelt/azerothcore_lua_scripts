local PlayerInventoryBagMapping = {}

function PlayerInventoryBagMapping.getBagMapping(characterGuid, targetName)
    local bagMapping = {}
    local bagItemToSlot = {}

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
        until not bagMappingResult:NextRow()
    end

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
        until not bankBagResult:NextRow()
    end

    return bagMapping, bagItemToSlot
end

function PlayerInventoryBagMapping.getBagSizes(targetName, characterGuid, bagMapping, bagItemToSlot, inventoryData, foundBagIds)
    local bagSizes = {}
    bagSizes[0] = 16

    local targetPlayer = GetPlayerByName(targetName)

    if targetPlayer then
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
                else
                    bagSizes[bagSlot] = 0
                end
            else
                bagSizes[bagSlot] = 0
            end
        end

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
                end
            end
        end
    else
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

    for _, item in ipairs(inventoryData) do
        if item.bag >= 67 and item.bag <= 73 then
            if not bagSizes[item.bag] then
                bagSizes[item.bag] = 28
            end
        end
    end

    for bagId, count in pairs(foundBagIds) do
        if bagId >= 35 and bagId <= 38 then
            local standardSlot = bagId - 35 + 19
            if not bagSizes[standardSlot] or bagSizes[standardSlot] == 0 then
                bagSizes[standardSlot] = 16
            end
        elseif bagId >= 23 and bagId <= 26 then
            local standardSlot = bagId - 23 + 19
            if not bagSizes[standardSlot] or bagSizes[standardSlot] == 0 then
                bagSizes[standardSlot] = 16
            end
        end
    end

    return bagSizes
end

function PlayerInventoryBagMapping.createBagConfiguration(bagSizes, bagIdToInfo)
    local bagConfiguration = {
        bagMapping = {},
        bagSizes = bagSizes,
    }

    for bagId, info in pairs(bagIdToInfo) do
        bagConfiguration.bagMapping[bagId] = {
            slot = info.slot,
            size = info.size,
            type = info.type,
            name = info.name,
            entry = info.entry
        }
    end

    bagConfiguration.bagMapping[0] = { slot = 0, size = 16, type = "backpack", name = "Backpack" }
    bagConfiguration.bagMapping[255] = { slot = 255, size = 0, type = "equipment", name = "Equipment" }
    bagConfiguration.bagMapping[-1] = { slot = -1, size = 28, type = "bank_main", name = "Bank" }

    return bagConfiguration
end

return PlayerInventoryBagMapping
