function RocknailRipper_OnEnterCombat(Unit,Event)
	Unit:RegisterUnitEvent("RocknailRipper_Rip", 11000, 0)
end

function RocknailRipper_Rip(Unit,Event)
	Unit:FullCastSpellOnTarget(37937,Unit:GetClosestPlayer())
end

function RocknailRipper_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function RocknailRipper_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21478, 1, "RocknailRipper_OnEnterCombat")
RegisterUnitEvent(21478, 2, "RocknailRipper_OnLeaveCombat")
RegisterUnitEvent(21478, 4, "RocknailRipper_OnDied")