function RocknailFlayer_OnEnterCombat(Unit,Event)
	Unit:RegisterUnitEvent("RocknailFlayer_FlayedFlesh", 30000, 0)
end

function RocknailFlayer_FlayedFlesh(Unit,Event)
	Unit:FullCastSpellOnTarget(37937,Unit:GetClosestPlayer())
end

function RocknailFlayer_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function RocknailFlayer_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21477, 1, "RocknailFlayer_OnEnterCombat")
RegisterUnitEvent(21477, 2, "RocknailFlayer_OnLeaveCombat")
RegisterUnitEvent(21477, 4, "RocknailFlayer_OnDied")