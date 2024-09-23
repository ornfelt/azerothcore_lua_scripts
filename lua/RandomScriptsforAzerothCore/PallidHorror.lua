local PallidHorror = {}

function PallidHorror.OnDied(event, creature, killer)
creature:CastSpell(creature, 28699, true)
end

RegisterCreatureEvent(16394, 4, PallidHorror.OnDied)