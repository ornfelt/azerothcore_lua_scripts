local SPELL_ID = 100191
local AURA_1 = 100003
local AURA_2 = 100168

function OnKilledByCreature(event, killer, killed)
    if (killed:HasAura(AURA_1) or killed:HasAura(AURA_2)) then
        if not killed:HasSpellCooldown(SPELL_ID) then
            killed:CastSpell(killed, SPELL_ID, false)
        end
    end
end

RegisterPlayerEvent(8, OnKilledByCreature)
