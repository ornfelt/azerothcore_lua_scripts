local RShredder = {}

RShredder.NPC_ID = 400044

function RShredder.OnSpawn(event, creature)
	creature:CastSpell(creature, 100169, true)
	creature:SetReactState(0)
end

function RShredder.OnDied(event, creature)
	creature:DespawnOrUnsummon(5000)
    creature:RemoveEvents()
end

RegisterCreatureEvent(RShredder.NPC_ID, 4, RShredder.OnDied)
RegisterCreatureEvent(RShredder.NPC_ID, 5, RShredder.OnSpawn)
