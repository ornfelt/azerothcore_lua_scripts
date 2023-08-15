function NPC_OnSpawn(Unit, Event)
Unit:CastSpell(32686)
end

RegisterUnitEvent(11502, 18, "NPC_OnSpawn")