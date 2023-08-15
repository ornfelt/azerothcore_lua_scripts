function VhelKur_OnSpawn(Unit,Event)
	Unit:CastSpell(36553)
end

RegisterUnitEvent(21801, 6, "VhelKur_OnSpawn")