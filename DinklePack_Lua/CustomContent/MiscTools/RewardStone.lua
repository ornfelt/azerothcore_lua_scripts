local ITEM_ID = 66000  -- The item ID

local function OnPlayerLogin(event, player)
    -- Check if the player already has the item
    if not player:HasItem(ITEM_ID) then
        -- If not, add the item to the player's inventory
        player:AddItem(ITEM_ID, 1)
    end
end

RegisterPlayerEvent(3, OnPlayerLogin)
