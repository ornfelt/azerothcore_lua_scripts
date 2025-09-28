--[[
    GameMaster UI - Player Inventory Equip Handlers Sub-Module
    
    This sub-module handles item equip/unequip operations:
    - Unequip items from equipment slots
    - Equip items to equipment slots
    - Equipment validation
    - Slot mapping
]]--

local PlayerInventoryEquipHandlers = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper

function PlayerInventoryEquipHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    
    -- Register equip/unequip handlers
    GameMasterSystem.unequipPlayerItem = PlayerInventoryEquipHandlers.unequipPlayerItem
    GameMasterSystem.equipPlayerItem = PlayerInventoryEquipHandlers.equipPlayerItem
end

-- Unequip item from player
function PlayerInventoryEquipHandlers.unequipPlayerItem(player, targetName, slotId)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    slotId = tonumber(slotId)
    if not slotId or slotId < 0 or slotId > 18 then
        Utils.sendMessage(player, "error", "Invalid equipment slot ID.")
        return
    end
    
    -- Find target player
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    -- Get the equipped item
    local item = targetPlayer:GetEquippedItemBySlot(slotId)
    if not item then
        Utils.sendMessage(player, "error", "No item equipped in slot " .. slotId)
        return
    end
    
    local itemName = item:GetName()
    local itemEntry = item:GetEntry()
    
    -- Check if player has bag space
    local hasSpace = false
    for bag = 0, 4 do
        for slot = 0, targetPlayer:GetBagSize(bag) - 1 do
            if not targetPlayer:GetItemByPos(bag, slot) then
                hasSpace = true
                break
            end
        end
        if hasSpace then break end
    end
    
    if not hasSpace then
        Utils.sendMessage(player, "error", "Player's inventory is full. Cannot unequip item.")
        return
    end
    
    -- Unequip the item (remove from slot and add to inventory)
    targetPlayer:RemoveItem(item, 1)
    local newItem = targetPlayer:AddItem(itemEntry, 1)
    
    if newItem then
        targetPlayer:SaveToDB()
        Utils.sendMessage(player, "success", string.format("Unequipped %s from %s.", itemName, targetName))
        targetPlayer:SendBroadcastMessage(string.format("GM %s unequipped your %s.", player:GetName(), itemName))
        
        -- Trigger inventory refresh through the main handler
        if GameMasterSystem.getPlayerInventory then
            GameMasterSystem.getPlayerInventory(player, targetName)
        end
    else
        Utils.sendMessage(player, "error", "Failed to unequip item.")
    end
end

-- Equip item on player
function PlayerInventoryEquipHandlers.equipPlayerItem(player, targetName, bag, slot)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    bag = tonumber(bag)
    slot = tonumber(slot)
    
    -- Find target player
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    -- Get the item from inventory
    local item = targetPlayer:GetItemByPos(bag, slot)
    if not item then
        Utils.sendMessage(player, "error", "Item not found at specified location.")
        return
    end
    
    local itemName = item:GetName()
    local itemEntry = item:GetEntry()
    
    -- Check if item is equipable by getting its inventory type from database
    local itemQuery = WorldDBQuery(string.format(
        "SELECT InventoryType FROM item_template WHERE entry = %d",
        itemEntry
    ))
    
    if not itemQuery then
        Utils.sendMessage(player, "error", "Failed to get item information.")
        return
    end
    
    local inventoryType = itemQuery:GetUInt32(0)
    
    -- Map inventory type to equipment slot using Utils table
    local equipSlot = Utils.inventoryTypeToSlot[inventoryType]
    
    if not equipSlot then
        Utils.sendMessage(player, "error", "This item cannot be equipped.")
        return
    end
    
    -- Special handling for rings and trinkets (can go in either slot)
    if inventoryType == 11 then -- Ring
        local ring1 = targetPlayer:GetEquippedItemBySlot(10)
        local ring2 = targetPlayer:GetEquippedItemBySlot(11)
        if not ring1 then
            equipSlot = 10
        elseif not ring2 then
            equipSlot = 11
        else
            equipSlot = 10 -- Default to first slot if both occupied
        end
    elseif inventoryType == 12 then -- Trinket
        local trinket1 = targetPlayer:GetEquippedItemBySlot(12)
        local trinket2 = targetPlayer:GetEquippedItemBySlot(13)
        if not trinket1 then
            equipSlot = 12
        elseif not trinket2 then
            equipSlot = 13
        else
            equipSlot = 12 -- Default to first slot if both occupied
        end
    end
    
    -- Check if there's already an item in the target slot
    local existingItem = targetPlayer:GetEquippedItemBySlot(equipSlot)
    
    -- Remove the item from inventory
    targetPlayer:RemoveItem(item, 1)
    
    -- If there was an existing item, add it to inventory
    if existingItem then
        local existingEntry = existingItem:GetEntry()
        targetPlayer:RemoveItem(existingItem, 1)
        targetPlayer:AddItem(existingEntry, 1)
    end
    
    -- Equip the new item
    local success = targetPlayer:EquipItem(itemEntry, equipSlot)
    
    if success then
        targetPlayer:SaveToDB()
        Utils.sendMessage(player, "success", string.format("Equipped %s on %s.", itemName, targetName))
        targetPlayer:SendBroadcastMessage(string.format("GM %s equipped %s on you.", player:GetName(), itemName))
        
        -- Trigger inventory refresh through the main handler
        if GameMasterSystem.getPlayerInventory then
            GameMasterSystem.getPlayerInventory(player, targetName)
        end
    else
        -- Try to restore the item if equip failed
        targetPlayer:AddItem(itemEntry, 1)
        Utils.sendMessage(player, "error", "Failed to equip item. It may not meet requirements.")
    end
end

return PlayerInventoryEquipHandlers