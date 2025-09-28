--[[
    GameMaster UI - Item Enchantment Handlers Module
    
    This module handles item enchantment operations:
    - Applying enchantments to items
    - Removing enchantments from items
    - Repairing items
]]--

local ItemEnchantmentHandlers = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper
local ItemUtilities = nil  -- Will be set after module registration

function ItemEnchantmentHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    
    -- Register enchantment handlers
    GameMasterSystem.enchantPlayerItem = ItemEnchantmentHandlers.enchantPlayerItem
    GameMasterSystem.removeItemEnchant = ItemEnchantmentHandlers.removeItemEnchant
    GameMasterSystem.repairPlayerItem = ItemEnchantmentHandlers.repairPlayerItem
end

-- Set ItemUtilities reference after module loading
function ItemEnchantmentHandlers.SetItemUtilities(utilities)
    ItemUtilities = utilities
end

-- Enchant a player's item
function ItemEnchantmentHandlers.enchantPlayerItem(player, targetName, slotInfo, enchantId, isEquipment)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    enchantId = tonumber(enchantId)
    if not enchantId or enchantId <= 0 then
        Utils.sendMessage(player, "error", "Invalid enchant ID.")
        return
    end
    
    -- Check if this is a random suffix enchantment (ID > 50000) and convert it
    if enchantId > 50000 then
        local suffixId = enchantId - 50000
        
        -- Load RandomSuffixData if needed
        local RandomSuffixData = _G.RandomSuffixData
        if not RandomSuffixData then
            local success, data = pcall(function()
                return require("GameMasterUI_RandomSuffixData")
            end)
            if success then
                RandomSuffixData = data
            end
        end
        
        if RandomSuffixData then
            local suffixData = RandomSuffixData.GetRandomSuffixById(suffixId)
            if suffixData and suffixData.enchants and suffixData.enchants[1] then
                -- Use the primary enchant ID from the suffix data
                local primaryEnchantId = suffixData.enchants[1][1]
                print(string.format("[ItemEnchantmentHandlers] Converting random suffix %s (ID: %d) to enchant ID: %d", 
                    suffixData.name, enchantId, primaryEnchantId))
                enchantId = primaryEnchantId
            end
        end
    end
    
    -- Find target player
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    local item = nil
    
    if isEquipment then
        -- Equipment slot
        local slotId = tonumber(slotInfo)
        if slotId then
            item = targetPlayer:GetEquippedItemBySlot(slotId)
            print(string.format("[ItemEnchantmentHandlers] Equipment enchant: slot %d, item found: %s", 
                slotId, item and "yes" or "no"))
        end
    else
        -- Inventory item (format: "bag:slot" or "bag:slot:guid")
        print(string.format("[ItemEnchantmentHandlers] === INVENTORY ENCHANT DEBUG ==="))
        print(string.format("[ItemEnchantmentHandlers] Received slotInfo: '%s'", tostring(slotInfo)))
        print(string.format("[ItemEnchantmentHandlers] Target player: %s", targetName))
        
        local bag, slot, itemGuid = string.match(slotInfo, "(%d+):(%d+):?(%d*)")
        if bag and slot then
            bag = tonumber(bag)
            slot = tonumber(slot)
            itemGuid = itemGuid and itemGuid ~= "" and tonumber(itemGuid) or nil
            
            print(string.format("[ItemEnchantmentHandlers] Parsed values - Bag: %d, Slot: %d, GUID: %s", 
                bag, slot, tostring(itemGuid)))
            
            -- Use item finding utility if available
            if ItemUtilities and ItemUtilities.findInventoryItem then
                item = ItemUtilities.findInventoryItem(targetPlayer, bag, slot, itemGuid)
            else
                -- Fallback to direct lookup
                item = targetPlayer:GetItemByPos(bag, slot)
            end
            
            if item then
                print(string.format("[ItemEnchantmentHandlers] Found item %s (ID: %d)", 
                    item:GetName(), item:GetEntry()))
            else
                print(string.format("[ItemEnchantmentHandlers] No item found"))
            end
        else
            print(string.format("[ItemEnchantmentHandlers] ERROR: Could not parse slotInfo: '%s'", tostring(slotInfo)))
        end
        print(string.format("[ItemEnchantmentHandlers] ================================"))
    end
    
    -- Special handling for custom bags - use direct database update
    if not item and not isEquipment then
        local bag, slot, itemGuid = string.match(slotInfo, "(%d+):(%d+):?(%d*)")
        bag = tonumber(bag)
        
        if bag and bag >= 1500 and itemGuid and itemGuid ~= "" then
            print(string.format("[ItemEnchantmentHandlers] CUSTOM BAG FALLBACK: Using direct DB update for bag %d, slot %d, GUID %s", 
                bag, slot, itemGuid))
            
            -- Update the enchantment directly in the database
            local updateQuery = string.format([[
                UPDATE item_instance 
                SET enchantments = CONCAT('%d ', SUBSTRING(enchantments, LOCATE(' ', enchantments) + 1))
                WHERE guid = %d
            ]], enchantId, tonumber(itemGuid))
            
            CharDBExecute(updateQuery)
            print(string.format("[ItemEnchantmentHandlers] Direct DB update executed for enchant %d on item GUID %d", enchantId, tonumber(itemGuid)))
            
            -- Force player to save and reload
            targetPlayer:SaveToDB()
            
            Utils.sendMessage(player, "success", string.format("Applied enchant %d to custom bag item (DB update).", enchantId))
            targetPlayer:SendBroadcastMessage(string.format("GM %s applied an enchantment to your item. You may need to relog to see it.", player:GetName()))
            
            return
        end
    end
    
    if not item then
        Utils.sendMessage(player, "error", "Item not found in specified location.")
        print("[ItemEnchantmentHandlers] ERROR: Final item check failed - item is nil")
        return
    end
    
    -- Apply enchantment (slot 0 = permanent enchant)
    print(string.format("[ItemEnchantmentHandlers] Attempting to apply enchant %d to item: %s", enchantId, item:GetName()))
    
    local success, err = pcall(function()
        item:SetEnchantment(enchantId, 0)
    end)
    
    if success then
        print(string.format("[ItemEnchantmentHandlers] SetEnchantment SUCCESS for enchant %d", enchantId))
        targetPlayer:SaveToDB()
        print("[ItemEnchantmentHandlers] Player data saved to DB")
        
        Utils.sendMessage(player, "success", string.format("Applied enchant %d to %s's item.", enchantId, targetName))
        targetPlayer:SendBroadcastMessage(string.format("GM %s applied an enchantment to your item.", player:GetName()))
    else
        print(string.format("[ItemEnchantmentHandlers] SetEnchantment FAILED: %s", tostring(err)))
        Utils.sendMessage(player, "error", string.format("Failed to apply enchantment: %s", tostring(err)))
    end
    
    -- Send update notifications
    ItemEnchantmentHandlers.sendItemUpdate(player, targetPlayer, item, slotInfo, isEquipment, enchantId)
end

-- Remove enchantments from a player's item
function ItemEnchantmentHandlers.removeItemEnchant(player, targetName, slotInfo, isEquipment)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    -- Find target player
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    local item = nil
    
    if isEquipment then
        -- Equipment slot
        local slotId = tonumber(slotInfo)
        if slotId then
            item = targetPlayer:GetEquippedItemBySlot(slotId)
        end
    else
        -- Inventory item (format: "bag:slot" or "bag:slot:guid")
        local bag, slot, itemGuid = string.match(slotInfo, "(%d+):(%d+):?(%d*)")
        if bag and slot then
            bag = tonumber(bag)
            slot = tonumber(slot)
            itemGuid = itemGuid and itemGuid ~= "" and tonumber(itemGuid) or nil
            
            print(string.format("[ItemEnchantmentHandlers] Remove enchant attempt: bag=%d, slot=%d, guid=%s, slotInfo='%s'", 
                bag, slot, tostring(itemGuid), tostring(slotInfo)))
            
            -- Use item finding utility if available
            if ItemUtilities and ItemUtilities.findInventoryItem then
                item = ItemUtilities.findInventoryItem(targetPlayer, bag, slot, itemGuid)
            else
                -- Fallback to direct lookup
                item = targetPlayer:GetItemByPos(bag, slot)
            end
        end
    end
    
    if not item then
        Utils.sendMessage(player, "error", "Item not found in specified location.")
        return
    end
    
    -- Remove all enchantments (clear slots 0-6)
    for enchantSlot = 0, 6 do
        item:ClearEnchantment(enchantSlot)
    end
    
    targetPlayer:SaveToDB()
    
    Utils.sendMessage(player, "success", string.format("Removed enchantments from %s's item.", targetName))
    targetPlayer:SendBroadcastMessage(string.format("GM %s removed enchantments from your item.", player:GetName()))
    
    -- Send update notifications
    ItemEnchantmentHandlers.sendItemUpdate(player, targetPlayer, item, slotInfo, isEquipment, 0)
end

-- Repair a player's item or all items
function ItemEnchantmentHandlers.repairPlayerItem(player, targetName, slotId, repairAll)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    -- Find target player
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    if repairAll then
        -- Repair all items (false = don't take money)
        targetPlayer:DurabilityRepairAll(false)
        Utils.sendMessage(player, "success", string.format("Repaired all equipment for %s.", targetName))
        targetPlayer:SendBroadcastMessage(string.format("GM %s repaired all your equipment.", player:GetName()))
    else
        -- Repair specific item
        local item = targetPlayer:GetEquippedItemBySlot(tonumber(slotId))
        if item then
            item:SetUInt32Value(60, item:GetMaxDurability()) -- ITEM_FIELD_DURABILITY
            targetPlayer:SaveToDB()
            Utils.sendMessage(player, "success", string.format("Repaired item in slot %d for %s.", slotId, targetName))
            targetPlayer:SendBroadcastMessage(string.format("GM %s repaired your item.", player:GetName()))
        else
            Utils.sendMessage(player, "error", "No item found in specified slot.")
        end
    end
    
    -- Refresh inventory display
    AIO.Handle(player, "GameMasterSystem", "refreshInventoryDisplay")
end

-- Helper function to send item update notifications
function ItemEnchantmentHandlers.sendItemUpdate(player, targetPlayer, item, slotInfo, isEquipment, enchantId)
    if not isEquipment then
        -- For inventory items, send specific item update
        local bag, slot = string.match(slotInfo, "(%d+):(%d+)")
        if bag and slot and item then
            bag = tonumber(bag)
            slot = tonumber(slot)
            
            -- Get item data
            local itemEntry = item:GetEntry()
            local itemCount = item:GetCount()
            local itemName = item:GetName()
            
            -- Get item template data
            local itemQuality = 0
            local displayId = 0
            local itemClass = 0
            local inventoryType = 0
            
            local itemInfoQuery = WorldDBQuery(string.format(
                "SELECT Quality, displayid, class, InventoryType FROM item_template WHERE entry = %d",
                itemEntry
            ))
            
            if itemInfoQuery then
                itemQuality = itemInfoQuery:GetUInt32(0) or 0
                displayId = itemInfoQuery:GetUInt32(1) or 0
                itemClass = itemInfoQuery:GetUInt32(2) or 0
                inventoryType = itemInfoQuery:GetUInt32(3) or 0
            end
            
            -- Get item GUID for custom bags
            local itemGuid = nil
            if bag >= 1500 then
                local guidQuery = CharDBQuery(string.format(
                    "SELECT item FROM character_inventory WHERE guid = %d AND bag = %d AND slot = %d",
                    targetPlayer:GetGUIDLow(), bag, slot
                ))
                if guidQuery then
                    itemGuid = guidQuery:GetUInt32(0)
                    print(string.format("[ItemEnchantmentHandlers] Found itemGuid %d for custom bag %d slot %d", itemGuid, bag, slot))
                end
            end
            
            local updatedItemData = {
                bag = bag,
                slot = slot,
                entry = itemEntry,
                count = itemCount,
                name = itemName,
                quality = itemQuality,
                displayId = displayId,
                class = itemClass,
                inventoryType = inventoryType,
                equipable = inventoryType > 0 and inventoryType ~= 18,
                enchantId = enchantId,
                itemGuid = itemGuid  -- Include GUID for custom bags
            }
            
            -- Send specific item update
            AIO.Handle(player, "GameMasterSystem", "updateSpecificInventoryItem", bag, slot, updatedItemData)
            print(string.format("[ItemEnchantmentHandlers] Sent specific inventory item update: bag %d, slot %d, enchantId %d", bag, slot, enchantId))
        else
            -- Fallback if something went wrong
            if Config and Config.debug then
                print("[ItemEnchantmentHandlers] Could not send specific update, client will use timer fallback")
            end
        end
    else
        -- For equipment, send specific equipment slot update
        local slotId = tonumber(slotInfo)
        if slotId and item then
            -- Get updated equipment item data
            local itemEntry = item:GetEntry()
            local itemCount = 1  -- Equipment is always count 1
            local itemName = item:GetName()
            
            -- Get item template data
            local itemQuality = 0
            local displayId = 0
            local itemClass = 0
            local inventoryType = 0
            
            local itemInfoQuery = WorldDBQuery(string.format(
                "SELECT Quality, displayid, class, InventoryType FROM item_template WHERE entry = %d",
                itemEntry
            ))
            
            if itemInfoQuery then
                itemQuality = itemInfoQuery:GetUInt32(0) or 0
                displayId = itemInfoQuery:GetUInt32(1) or 0
                itemClass = itemInfoQuery:GetUInt32(2) or 0
                inventoryType = itemInfoQuery:GetUInt32(3) or 0
            end
            
            local updatedEquipmentData = {
                slotId = slotId,
                entry = itemEntry,
                count = itemCount,
                name = itemName,
                quality = itemQuality,
                displayId = displayId,
                class = itemClass,
                inventoryType = inventoryType,
                enchantId = enchantId
            }
            
            -- Send specific equipment slot update
            AIO.Handle(player, "GameMasterSystem", "updateSpecificEquipmentSlot", slotId, updatedEquipmentData)
            print(string.format("[ItemEnchantmentHandlers] Sent specific equipment slot update: slot %d, enchantId %d", slotId, enchantId))
        else
            -- Fallback to full refresh if something went wrong
            AIO.Handle(player, "GameMasterSystem", "refreshInventoryDisplay")
        end
    end
end

return ItemEnchantmentHandlers