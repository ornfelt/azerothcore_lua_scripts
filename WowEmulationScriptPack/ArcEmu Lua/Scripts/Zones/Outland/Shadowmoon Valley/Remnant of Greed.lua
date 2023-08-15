function RemnantofGreed_OnSpawn(Unit,Event)
	Unit:CastSpell(39168)
end

RegisterUnitEvent(22438, 6, "RemnantofGreed_OnSpawn")