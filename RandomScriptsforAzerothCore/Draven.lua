local Draven = {};

function Draven.OnEnterCombat(event, creature, target)
	creature:RegisterEvent(Draven.CastFanOfKnives, 10000, 0)
	creature:RegisterEvent(Draven.CastSaroniteBomb, 7000, 0)
	creature:RegisterEvent(Draven.CastCloakOfShadows, 11500, 0)
	creature:RegisterEvent(Draven.CastBladeFlurry, 13000, 0)
end

function Draven.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function Draven.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

function Draven.CastFanOfKnives(event, delay, calls, creature)
	creature:CastSpell(creature:GetVictim(), 51723, true)
end

function Draven.CastSaroniteBomb(event, delay, calls, creature)
	creature:CastSpell(creature:GetVictim(), 56350, true)
end

function Draven.CastCloakOfShadows(event, delay, calls, creature)
	creature:CastSpell(creature, 31224, true)
end

function Draven.CastBladeFlurry(event, delay, calls, creature)
	creature:CastSpell(creature, 13877, true)
end

RegisterCreatureEvent(400069, 1, Draven.OnEnterCombat)
RegisterCreatureEvent(400069, 2, Draven.OnLeaveCombat)
RegisterCreatureEvent(400069, 4, Draven.OnDied)

