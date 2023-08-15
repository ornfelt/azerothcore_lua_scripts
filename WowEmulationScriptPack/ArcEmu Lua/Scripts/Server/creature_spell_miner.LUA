function NPC_OnSpawn(Unit, Event)
Unit:CastSpell(3564)
end

RegisterUnitEvent(40, 18, "NPC_OnSpawn")