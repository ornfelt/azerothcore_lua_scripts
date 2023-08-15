function DNetherDrake_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("DNetherDrake_ArcaneBlast", 11000, 0)
end

function DNetherDrake_ArcaneBlast(Unit,Event)
	Unit:FullCastSpellOnTarget(38344,Unit:GetClosestPlayer())
end

function DNetherDrake_LeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function DNetherDrake_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(22000, 1, "DNetherDrake_OnEnterCombat")
RegisterUnitEvent(22000, 2, "DNetherDrake_LeaveCombat")
RegisterUnitEvent(22000, 4, "DNetherDrake_OnDied")