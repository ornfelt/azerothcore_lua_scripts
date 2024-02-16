local Laurena = {}

Laurena.NPC_ID = 376
Laurena.SPELL_IDS = {
    SMITE = 10934
}

function Laurena.CastSmite(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Laurena.SPELL_IDS.SMITE, true)
end

function Laurena.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(Laurena.CastSmite, 3000, 0)
end

function Laurena.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function Laurena.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(Laurena.NPC_ID, 1, Laurena.OnEnterCombat)
RegisterCreatureEvent(Laurena.NPC_ID, 2, Laurena.OnLeaveCombat)
RegisterCreatureEvent(Laurena.NPC_ID, 4, Laurena.OnDied)
