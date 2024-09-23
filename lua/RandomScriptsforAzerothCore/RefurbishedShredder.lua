local RShredder = {};

function RShredder.OnSpawn(event, creature)
	creature:CastSpell(creature, 100169, true)
	creature:SetReactState(0)
end

function RShredder.OnDied(event, creature)
	creature:DespawnOrUnsummon(5000)
    creature:RemoveEvents()
end

RegisterCreatureEvent(400044, 4, RShredder.OnDied)
RegisterCreatureEvent(400044, 5, RShredder.OnSpawn)
