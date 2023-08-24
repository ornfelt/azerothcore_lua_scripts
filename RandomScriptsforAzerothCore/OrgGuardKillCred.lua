-- A table of NPC IDs to be considered as valid targets
local OG_ID = {400059, 400060, 400061, 400014, 400041, 400040, 400039, 3296}
-- The ID of the spell that is used to interact with the NPCs
local SPELL_ID = 100183

-- A function that is triggered whenever a player casts a spell
function OnSpellCast(event, caster, spell)
    -- Get the target of the spell being cast
    local target = spell:GetTarget()

    -- If the target exists and the spell being cast is the specified spell
    if target and spell:GetEntry() == SPELL_ID then
        -- A flag to determine if the target is a valid NPC
        local isValidTarget = false

        -- Iterate through the table of valid NPC IDs
        for _, OGID in ipairs(OG_ID) do
            -- If the target's NPC ID matches one of the valid IDs
            if target:GetEntry() == OGID then
                -- Set the flag to true
                isValidTarget = true
                -- Break out of the loop
                break
            end
        end

        -- If the target is not a valid NPC or if the target's health is greater than 90%
        if not isValidTarget or target:GetHealthPct() > 90 then
            -- Send a broadcast message to the player
            caster:SendBroadcastMessage("That defender is doing fine. Find one that needs more help!")
            -- Cancel the spell
            spell:Cancel()
        else
            -- Give kill credit to NPC ID 400039
            caster:KilledMonsterCredit(400039)
        end
    end
end

-- Register the function to be triggered whenever a player casts a spell (event 5)
RegisterPlayerEvent(5, OnSpellCast)
