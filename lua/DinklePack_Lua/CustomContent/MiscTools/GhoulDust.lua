local DeathTrigger = {}

DeathTrigger.ITEM_ID = 60090 -- The item ID to check for
DeathTrigger.SPELL_ID = 46619 -- The spell ID to cast
DeathTrigger.CAST_CHANCE = 30 -- The chance percentage to cast the spell
DeathTrigger.DELAY = 1000 -- Delay in milliseconds (1000 ms = 1 second)

function DeathTrigger.HasEquippedItem(player, itemID)
    for slot = 1, 18 do
        local item = player:GetEquippedItemBySlot(slot)
        if item and item:GetEntry() == itemID then
            return true
        end
    end
    return false
end

function DeathTrigger.CastDelayedSpell(playerGUID)
    local player = GetPlayerByGUID(playerGUID)
    if player then
        player:CastSpell(player, DeathTrigger.SPELL_ID, true)
    end
end

function DeathTrigger.OnPlayerDeath(event, killer, killed)
    -- Check if the killed player has the item equipped
    if DeathTrigger.HasEquippedItem(killed, DeathTrigger.ITEM_ID) then
        -- Roll for the chance to cast the spell
        if math.random(1, 100) <= DeathTrigger.CAST_CHANCE then
            local killedGUID = killed:GetGUID()
            -- Schedule the delayed spell cast
            CreateLuaEvent(function() DeathTrigger.CastDelayedSpell(killedGUID) end, DeathTrigger.DELAY, 1)
        end
    end
end

RegisterPlayerEvent(8, DeathTrigger.OnPlayerDeath) -- Register the event handler for player death
