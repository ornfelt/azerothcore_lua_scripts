local SPELL_ID = 51916

function OnKilledByCreature(event, killer, killed)
    killed:CastSpell(killed, SPELL_ID, true)
end

RegisterPlayerEvent(8, OnKilledByCreature)
