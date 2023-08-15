function MatureNetherwingDrake_OnEnterCombat(Unit,Event)
	Unit:CastSpell(38502)
	Unit:RegisterEvent("MatureNetherwingDrake_IntangiblePresence", 16000, 0)
	Unit:RegisterEvent("MatureNetherwingDrake_Netherbreath", 5000, 0)
end

function MatureNetherwingDrake_IntangiblePresence(Unit,Event)
	Unit:FullCastSpellOnTarget(36513,Unit:GetClosestPlayer())
end

function MatureNetherwingDrake_Netherbreath(Unit,Event)
	Unit:FullCastSpellOnTarget(38467,Unit:GetClosestPlayer())
end

function MatureNetherwingDrake_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function MatureNetherwingDrake_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21648, 1, "MatureNetherwingDrake_OnEnterCombat")
RegisterUnitEvent(21648, 2, "MatureNetherwingDrake_OnLeaveCombat")
RegisterUnitEvent(21648, 4, "MatureNetherwingDrake_OnDied")