-- This function is defined to remove a specific item from a player's inventory after a delay.
-- It's called as a timed event registered for each player when they loot an item.
local function RemoveItemDelayed(eventId, delay, repeats, player)
    -- Retrieves the item ID saved earlier in the player object.
    local itemId = player:GetData("temp_itemId")
    -- If the itemId exists (meaning it was set in the OnLoot function), 
    -- then we proceed to remove the item.
    if itemId then
        -- Remove one unit of the item from the player's inventory.
        player:RemoveItem(itemId, 1)
        -- The itemId is cleared after it's used to ensure that the same item 
        -- is not mistakenly removed multiple times.
        player:SetData("temp_itemId", nil)
    end
end

-- This function is called whenever a player loots an item (event 32).
local function OnLoot(event, player, item, count)
    -- Retrieves the map ID where the player currently is.
    local mapId = player:GetMapId()
    -- Retrieves the current level of the player.
    local playerLevel = player:GetLevel()
    -- Checks if the player is on map 532 (Kara) and their level is 60 or lower.
    if mapId == 532 and playerLevel <= 60 then
        -- Retrieves the ID of the looted item.
        local itemId = item:GetEntry()
        -- Checks if the item ID is within the desired range (15000-40000). These are ranges for most tbc items. I was being lazy here.
        if itemId >= 15000 and itemId <= 40000 then
            -- If it is, the itemId is temporarily saved in the player object for later use.
            player:SetData("temp_itemId", itemId)
            -- Register the RemoveItemDelayed function to be called after a delay of 500ms. Delay was added because otherwise server crashes occured.
            -- This function will remove the looted item from the player's inventory.
            player:RegisterEvent(RemoveItemDelayed, 500, 1)
        end
    end
end

-- Register the OnLoot function to be called whenever event 32 (PLAYER_EVENT_ON_LOOT_ITEM) is triggered.
-- This means that every time a player loots an item, the OnLoot function will be called.
RegisterPlayerEvent(32, OnLoot)
