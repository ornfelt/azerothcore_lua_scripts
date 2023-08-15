function WaterSpirit_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("WaterSpirit_Waterbolt", 4300, 0)
end

function Waterspirit_WaterBolt(Unit,Event)
	Unit:FullCastSpellOnTarget(31707,Unit:GetClosestPlayer())
end

function WaterSpirit_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function WaterSpirit_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21029, 1, "WaterSpirit_OnEnterCombat")
RegisterUnitEvent(21029, 2, "WaterSpirit_OnLeaveCombat")
RegisterUnitEvent(21029, 4, "WaterSpirit_OnDied")