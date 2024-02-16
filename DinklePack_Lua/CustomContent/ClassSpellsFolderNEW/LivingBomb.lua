--[[

local spells_to_cast = {
    [44461] = 44457,
    [55361] = 55359,
    [55362] = 55360
}

local scriptEnabled = false -- The script is disabled by default

function OnSpellCast(event, player, spell, skipCheck)
    -- Only run the script if it's enabled
    if scriptEnabled then
        local spell_id = spell:GetEntry()

        -- Check if spell is one of the Living Bomb spells
        if spells_to_cast[spell_id] then
            -- Get target creature
            local target = spell:GetTarget()

            -- If target is a creature
            if target:GetTypeId() == 3 then
                -- Get nearby creatures
                local nearby_creatures = target:GetCreaturesInRange(10)

                -- Cast the corresponding spell on each creature
                for i, creature in ipairs(nearby_creatures) do
                    player:CastSpell(creature, spells_to_cast[spell_id], true)
                end
            end
        end
    end
end

-- This function allows you to toggle the script on and off
function EnableDisableScript(event, player, message, type, lang)
    if player:IsGM() then -- Check if the player has GM privileges
	if message == "living bomb script on" then
        scriptEnabled = true
        player:SendBroadcastMessage("Living Bomb chain reaction script has been enabled.")
        return false
    elseif message == "living bomb script off" then
        scriptEnabled = false
        player:SendBroadcastMessage("Living Bomb chain reaction script has been disabled.")
        return false
        end
    else
      --  player:SendBroadcastMessage("You do not have permission to use this command.")
    end
end

RegisterPlayerEvent(5, OnSpellCast)
RegisterPlayerEvent(18, EnableDisableScript) -- 18 is for chat command events
]]

