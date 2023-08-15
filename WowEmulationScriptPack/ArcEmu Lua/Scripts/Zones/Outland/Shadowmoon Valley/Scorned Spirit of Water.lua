function ScornedSpiritofWater_OnSpawn(Unit,Event)
	Unit:CastSpell(36206)
end

RegisterUnitEvent(21131, 6, "ScornedSpiritofWater_OnSpawn")