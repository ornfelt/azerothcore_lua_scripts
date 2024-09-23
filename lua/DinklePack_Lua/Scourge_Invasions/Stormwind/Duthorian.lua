local DuthorianRall = {}

DuthorianRall.NPC_ID = 6171
DuthorianRall.SPELL_IDS = {
    JUDGEMENT_OF_LIGHT = 20185
}

function DuthorianRall.CastJoL(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), DuthorianRall.SPELL_IDS.JUDGEMENT_OF_LIGHT, true)
end

function DuthorianRall.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(DuthorianRall.CastJoL, 5000, 0)
end
	
function DuthorianRall.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function DuthorianRall.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(DuthorianRall.NPC_ID, 1, DuthorianRall.OnEnterCombat)
RegisterCreatureEvent(DuthorianRall.NPC_ID, 2, DuthorianRall.OnLeaveCombat)
RegisterCreatureEvent(DuthorianRall.NPC_ID, 4, DuthorianRall.OnDied)
