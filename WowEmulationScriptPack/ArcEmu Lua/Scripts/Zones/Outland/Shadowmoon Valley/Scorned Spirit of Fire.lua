function ScornedSpiritofFire_OnSpawn(Unit,Event)
	Unit:CastSpell(36206)
end

RegisterUnitEvent(21130, 6, "ScornedSpiritofFire_OnSpawn")