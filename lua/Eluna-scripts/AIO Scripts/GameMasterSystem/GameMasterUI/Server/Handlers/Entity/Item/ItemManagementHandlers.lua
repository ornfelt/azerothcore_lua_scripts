--[[
    GameMaster UI - Item Management Handlers Module
    
    This module handles basic item management operations:
    - Adding items to players
    - Giving items to players
    - Maximum stack operations
]]--

local ItemManagementHandlers = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper

function ItemManagementHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    
    -- Register management handlers
    GameMasterSystem.addItemEntity = ItemManagementHandlers.addItemEntity
    GameMasterSystem.addItemEntityMax = ItemManagementHandlers.addItemEntityMax
    GameMasterSystem.givePlayerItem = ItemManagementHandlers.givePlayerItem
    GameMasterSystem.addItemToPlayer = ItemManagementHandlers.addItemToPlayer
end

-- Server-side handler to add item to target or player
function ItemManagementHandlers.addItemEntity(player, itemID, amount)
    print("Adding item to target or player" .. itemID .. " amount: " .. amount)
    -- Validate inputs
    itemID = tonumber(itemID)
    amount = tonumber(amount) or 1

    if not itemID or itemID <= 0 then
        Utils.sendMessage(player, "error", "Invalid item ID.")
        return
    end

    if amount <= 0 or amount > 100 then
        amount = 1 -- Sanitize amount
    end

    local target, isSelf = GameMasterSystem.getTarget(player)

    -- Verify item exists
    local itemQuery = WorldDBQuery("SELECT entry FROM item_template WHERE entry = " .. itemID)
    if not itemQuery then
        Utils.sendMessage(player, "error", "Item ID " .. itemID .. " does not exist.")
        return
    end

    local success = target:AddItem(itemID, amount)

    if success then
        if isSelf then
            Utils.sendMessage(player, "success", string.format("Added %d x item %d to your inventory.", amount, itemID))
        else
            Utils.sendMessage(player, "success", string.format("Added %d x item %d to %s's inventory.",
                amount, itemID, target:GetName()))
        end
    else
        Utils.sendMessage(player, "error", "Failed to add item. Inventory might be full.")
    end
end

function ItemManagementHandlers.addItemEntityMax(player, itemID)
    -- Validate inputs
    itemID = tonumber(itemID)

    if not itemID or itemID <= 0 then
        Utils.sendMessage(player, "error", "Invalid item ID.")
        return
    end

    local target, isSelf = GameMasterSystem.getTarget(player)

    -- Query item information from database
    local itemQuery = WorldDBQuery(string.format(
        "SELECT entry, name, stackable FROM item_template WHERE entry = %d",
        itemID
    ))

    if not itemQuery then
        Utils.sendMessage(player, "error", "Item ID " .. itemID .. " does not exist.")
        return
    end

    -- Get stack size
    local itemName = itemQuery:GetString(1)
    local maxStack = itemQuery:GetUInt32(2)

    -- Ensure valid stack size
    if not maxStack or maxStack <= 0 then
        maxStack = 1
    elseif maxStack > 1000 then
        maxStack = 1000  -- Safety cap
    end

    -- Add item to target's inventory
    local success = target:AddItem(itemID, maxStack)

    if success then
        if isSelf then
            Utils.sendMessage(
                player,
                "success",
                string.format("Added maximum stack (%d) of %s to your inventory.",
                    maxStack, itemName or "item #" .. itemID)
            )
        else
            Utils.sendMessage(
                player,
                "success",
                string.format("Added maximum stack (%d) of %s to %s's inventory.",
                    maxStack, itemName or "item #" .. itemID, target:GetName())
            )
        end
    else
        Utils.sendMessage(player, "error", "Failed to add item. Inventory might be full.")
    end
end

function ItemManagementHandlers.givePlayerItem(player, targetName, itemId, count)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    itemId = tonumber(itemId)
    count = tonumber(count) or 1
    
    if not itemId or itemId <= 0 then
        Utils.sendMessage(player, "error", "Invalid item ID.")
        return
    end
    
    if count <= 0 then
        count = 1
    end
    
    -- Find target player
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    -- Verify item exists
    local itemQuery = WorldDBQuery("SELECT name FROM item_template WHERE entry = " .. itemId)
    if not itemQuery then
        Utils.sendMessage(player, "error", "Item ID " .. itemId .. " does not exist.")
        return
    end
    
    local itemName = itemQuery:GetString(0)
    
    -- Add item to target
    local success = targetPlayer:AddItem(itemId, count)
    
    if success then
        Utils.sendMessage(player, "success", string.format("Gave %dx %s to %s.", count, itemName, targetName))
        targetPlayer:SendBroadcastMessage(string.format("You received %dx %s from GM %s.", count, itemName, player:GetName()))
    else
        Utils.sendMessage(player, "error", "Failed to give item. Target's inventory might be full.")
    end
end

-- Add items to player (alias for givePlayerItem called from inventory context)
function ItemManagementHandlers.addItemToPlayer(player, targetName, itemEntry, count)
    ItemManagementHandlers.givePlayerItem(player, targetName, itemEntry, count)
end

return ItemManagementHandlers