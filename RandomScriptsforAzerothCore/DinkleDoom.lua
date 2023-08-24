local Dinkledork = {}

function Dinkledork.OnSpawn(event, creature)
creature:CastSpell(creature, 100138, true)
creature:CastSpell(creature, 100035, true)
end

RegisterCreatureEvent(400066, 5, Dinkledork.OnSpawn)