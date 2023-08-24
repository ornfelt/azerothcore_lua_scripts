local ITEM_ID = 60090 -- The item ID to check for
local SPELL_ID = 46619 -- The spell ID to cast
local CAST_CHANCE = 30 -- The chance percentage to cast the spell
local DELAY = 1000 -- Delay in milliseconds (1000 ms = 1 second)

local function HasEquippedItem(player, itemID)
    for slot = 1, 18 do
        local item = player:GetEquippedItemBySlot(slot)
        if item and item:GetEntry() == itemID then
            return true
        end
    end
    return false
end

local function CastDelayedSpell(playerGUID)
    local player = GetPlayerByGUID(playerGUID)
    if player then
        player:CastSpell(player, SPELL_ID, true)
    end
end

local function OnPlayerDeath(event, killer, killed)
    -- Check if the killed player has the item equipped
    if HasEquippedItem(killed, ITEM_ID) then
        -- Roll for the chance to cast the spell
        if math.random(1, 100) <= CAST_CHANCE then
            local killedGUID = killed:GetGUID()
            -- Schedule the delayed spell cast
            CreateLuaEvent(function() CastDelayedSpell(killedGUID) end, DELAY, 1)
        end
    end
end

RegisterPlayerEvent(8, OnPlayerDeath) -- Register the event handler for player death
