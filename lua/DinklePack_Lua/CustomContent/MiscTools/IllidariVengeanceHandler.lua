local DhSpellModifier = {}

function DhSpellModifier.OnSpellCast(event, player, spell, skipCheck)
    local target = player:GetSelection()
    if target == nil then
        return
    end

    if target:GetCreatureType() == 3 then
        local playerRace = player:GetRace()
        if playerRace == 20 or playerRace == 21 then
            if not player:HasAura(100238) then
                player:AddAura(100238, player)
            end
        end
    end
end

RegisterPlayerEvent(5, DhSpellModifier.OnSpellCast)
