function Haalum_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Haalum_Chain", 15000, 0)
	Unit:RegisterEvent("Haalum_LBolt", 9000, 0)
end

function Haalum_Chain(Unit,Event)
	Unit:FullCastSpellOnTarget(12058,Unit:GetClosestPlayer())
end

function Haalum_LBolt(Unit,Event)
	Unit:FullCastSpellOnTarget(9532,Unit:GetClosestPlayer())
end

function Haalum_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Haalum_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21711, 1, "Haalum_OnEnterCombat")
RegisterUnitEvent(21711, 2, "Haalum_OnLeaveCombat")
RegisterUnitEvent(21711, 4, "Haalum_OnDied")