--[[
    GameMaster UI - Item Inventory Handlers Module
    
    This module handles inventory-specific item operations:
    - Duplicating items
    - Splitting stacks
    - Modifying stack counts
    - Deleting items from inventory
]]--

local ItemInventoryHandlers = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper
local PlayerHandlers = nil  -- Will be set after all modules are loaded

function ItemInventoryHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    
    -- Register inventory handlers
    GameMasterSystem.duplicatePlayerItem = ItemInventoryHandlers.duplicatePlayerItem
    GameMasterSystem.splitItemStack = ItemInventoryHandlers.splitItemStack
    GameMasterSystem.modifyItemStack = ItemInventoryHandlers.modifyItemStack
    GameMasterSystem.deleteInventoryItem = ItemInventoryHandlers.deleteInventoryItem
    GameMasterSystem.deleteEquippedItem = ItemInventoryHandlers.deleteEquippedItem
end

-- Set PlayerHandlers reference after all modules are loaded
function ItemInventoryHandlers.SetPlayerHandlers(handlers)
    PlayerHandlers = handlers
end

-- Duplicate a player's item
function ItemInventoryHandlers.duplicatePlayerItem(player, targetName, itemEntry, count)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    itemEntry = tonumber(itemEntry)
    count = tonumber(count) or 1
    
    if not itemEntry or itemEntry <= 0 then
        Utils.sendMessage(player, "error", "Invalid item ID.")
        return
    end
    
    if count <= 0 then count = 1 end
    if count > 255 then count = 255 end -- Safety limit
    
    -- Find target player
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    -- Add duplicate item
    local success = targetPlayer:AddItem(itemEntry, count)
    
    if success then
        Utils.sendMessage(player, "success", string.format("Duplicated %dx item %d for %s.", count, itemEntry, targetName))
        targetPlayer:SendBroadcastMessage(string.format("GM %s duplicated an item for you.", player:GetName()))
        
        -- Refresh inventory display
        AIO.Handle(player, "GameMasterSystem", "refreshInventoryDisplay")
    else
        Utils.sendMessage(player, "error", "Failed to duplicate item. Inventory might be full.")
    end
end

-- Split an item stack
function ItemInventoryHandlers.splitItemStack(player, targetName, bag, slot, splitAmount)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    bag = tonumber(bag)
    slot = tonumber(slot)
    splitAmount = tonumber(splitAmount)
    
    if not splitAmount or splitAmount <= 0 then
        Utils.sendMessage(player, "error", "Invalid split amount.")
        return
    end
    
    -- Find target player
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    -- Get the item
    local item = targetPlayer:GetItemByPos(bag, slot)
    if not item then
        Utils.sendMessage(player, "error", "Item not found at specified location.")
        return
    end
    
    local currentCount = item:GetCount()
    if currentCount <= splitAmount then
        Utils.sendMessage(player, "error", "Split amount must be less than current stack.")
        return
    end
    
    -- Reduce current stack
    item:SetCount(currentCount - splitAmount)
    
    -- Add new stack
    local itemEntry = item:GetEntry()
    local newItem = targetPlayer:AddItem(itemEntry, splitAmount)
    
    if newItem then
        targetPlayer:SaveToDB()
        Utils.sendMessage(player, "success", string.format("Split stack: %d items separated.", splitAmount))
        
        -- Refresh inventory display
        AIO.Handle(player, "GameMasterSystem", "refreshInventoryDisplay")
    else
        -- Restore original count if failed
        item:SetCount(currentCount)
        Utils.sendMessage(player, "error", "Failed to split stack. Inventory might be full.")
    end
end

-- Modify item stack count
function ItemInventoryHandlers.modifyItemStack(player, targetName, bag, slot, newCount)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    bag = tonumber(bag)
    slot = tonumber(slot)
    newCount = tonumber(newCount)
    
    if not newCount or newCount <= 0 then
        Utils.sendMessage(player, "error", "Invalid count.")
        return
    end
    
    if newCount > 255 then newCount = 255 end -- Safety limit
    
    -- Find target player
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    -- Get the item
    local item = targetPlayer:GetItemByPos(bag, slot)
    if not item then
        Utils.sendMessage(player, "error", "Item not found at specified location.")
        return
    end
    
    -- Check max stack from database
    local itemEntry = item:GetEntry()
    local stackQuery = WorldDBQuery(string.format(
        "SELECT stackable FROM item_template WHERE entry = %d",
        itemEntry
    ))
    
    local maxStack = 1
    if stackQuery then
        maxStack = stackQuery:GetUInt32(0)
        if maxStack <= 0 then maxStack = 1 end
    end
    
    if newCount > maxStack then
        newCount = maxStack
        Utils.sendMessage(player, "warning", string.format("Count limited to max stack size: %d", maxStack))
    end
    
    -- Set new count
    item:SetCount(newCount)
    targetPlayer:SaveToDB()
    
    Utils.sendMessage(player, "success", string.format("Modified stack count to %d for %s.", newCount, targetName))
    
    -- Refresh inventory display
    AIO.Handle(player, "GameMasterSystem", "refreshInventoryDisplay")
end

-- Delete item from inventory
function ItemInventoryHandlers.deleteInventoryItem(player, targetName, itemEntry, itemCount, bag, slot)
    print(string.format("[ItemInventoryHandlers] deleteInventoryItem called: player=%s, target=%s, entry=%s, count=%s, bag=%s, slot=%s",
        player:GetName(), targetName, tostring(itemEntry), tostring(itemCount), tostring(bag), tostring(slot)))
    
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    -- Convert parameters to numbers
    itemEntry = tonumber(itemEntry)
    itemCount = tonumber(itemCount) or 1
    bag = tonumber(bag)  -- Keep for logging
    slot = tonumber(slot)  -- Keep for logging
    
    -- Validate required parameters
    if not itemEntry or itemEntry <= 0 then
        Utils.sendMessage(player, "error", "Invalid item ID provided.")
        print("[ItemInventoryHandlers] ERROR: Invalid or missing item entry")
        return
    end
    
    if itemCount <= 0 then
        itemCount = 1
    end
    
    -- Find target player
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    -- Get item name for messaging (optional, for better UX)
    local itemName = "Unknown Item"
    local nameQuery = WorldDBQuery(string.format("SELECT name FROM item_template WHERE entry = %d", itemEntry))
    if nameQuery then
        itemName = nameQuery:GetString(0)
    end
    
    print(string.format("[ItemInventoryHandlers] Removing item: %s (ID: %d) x%d from %s (bag: %d, slot: %d for reference)",
        itemName, itemEntry, itemCount, targetName, bag or -1, slot or -1))
    
    -- Use the simple RemoveItem API - it removes items from anywhere in the inventory
    local removed = targetPlayer:RemoveItem(itemEntry, itemCount)
    
    -- Save player data
    targetPlayer:SaveToDB()
    
    if removed then
        Utils.sendMessage(player, "success", string.format("Deleted %dx %s from %s's inventory.",
            itemCount, itemName, targetName))
        targetPlayer:SendBroadcastMessage(string.format("GM %s removed %dx %s from your inventory.",
            player:GetName(), itemCount, itemName))
        
        -- Send inventory update notification
        AIO.Handle(player, "GameMasterSystem", "handleInventoryUpdate", "remove", nil, bag, slot)
    else
        Utils.sendMessage(player, "error", string.format("Failed to remove %dx %s. Item may not exist in inventory.",
            itemCount, itemName))
        
        -- Still refresh inventory in case something changed
        AIO.Handle(player, "GameMasterSystem", "refreshInventoryDisplay")
    end
end

-- Delete equipped item
function ItemInventoryHandlers.deleteEquippedItem(player, targetName, slotId)
    print(string.format("[ItemInventoryHandlers] deleteEquippedItem called: player=%s, target=%s, slotId=%s",
        player:GetName(), targetName, tostring(slotId)))
    
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    slotId = tonumber(slotId)
    
    if not slotId then
        Utils.sendMessage(player, "error", "Invalid slot ID provided.")
        print("[ItemInventoryHandlers] ERROR: slotId is nil after conversion")
        return
    end
    
    print(string.format("[ItemInventoryHandlers] Looking for equipped item at slot %d", slotId))
    
    -- Find target player
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    -- Get the equipped item
    local item = targetPlayer:GetEquippedItemBySlot(slotId)
    if not item then
        print(string.format("[ItemInventoryHandlers] No item found at equipment slot %d", slotId))
        Utils.sendMessage(player, "error", string.format("No item equipped in slot %d", slotId))
        
        -- Still refresh to update display
        AIO.Handle(player, "GameMasterSystem", "refreshInventoryDisplay")
        return
    end
    
    local itemName = item:GetName()
    local itemEntry = item:GetEntry()
    local itemCount = item:GetCount()
    
    print(string.format("[ItemInventoryHandlers] Removing equipped item: %s (entry=%d) from slot %d", 
        itemName, itemEntry, slotId))
    
    -- For equipped items, unequip first then remove
    local removed = false
    
    -- Try to unequip the item first
    targetPlayer:EquipItem(0, slotId) -- Equip nothing to the slot
    
    -- Now remove the item
    if item and item:GetGUIDLow() > 0 then
        -- Method 1: Set count to 0 to destroy
        item:SetCount(0)
        removed = true
    end
    
    -- Fallback to RemoveItem if needed
    if not removed then
        removed = targetPlayer:RemoveItem(itemEntry, itemCount)
    end
    
    -- Always save to database immediately
    targetPlayer:SaveToDB()
    
    if removed then
        Utils.sendMessage(player, "success", string.format("Deleted %s from %s's equipment (slot %d).", 
            itemName, targetName, slotId))
        targetPlayer:SendBroadcastMessage(string.format("GM %s removed %s from your equipment.", 
            player:GetName(), itemName))
        
        -- Send equipment update notification
        AIO.Handle(player, "GameMasterSystem", "updateSpecificEquipmentSlot", slotId, nil)
    else
        print(string.format("[ItemInventoryHandlers] WARNING: Equipped item removal may have failed for %s", itemName))
        Utils.sendMessage(player, "warning", string.format("Equipped item %s removal attempted. Please verify.", itemName))
        
        -- Still send refresh in case something changed
        AIO.Handle(player, "GameMasterSystem", "handleInventoryUpdate", "refresh", nil, nil, nil)
    end
end

return ItemInventoryHandlers