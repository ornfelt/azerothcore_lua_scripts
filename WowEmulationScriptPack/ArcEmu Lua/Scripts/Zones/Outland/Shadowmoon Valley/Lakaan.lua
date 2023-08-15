function Lakaan_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Lakaan_WaterBolt", 4000, 0)
end

function Lakaan_WaterBolt(Unit,Event)
	Unit:FullCastSpellOnTarget(32011,Unit:GetClosestPlayer())
end

function Lakaan_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Lakaan_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21416, 1, "Lakaan_OnEnterCombat")
RegisterUnitEvent(21416, 2, "Lakaan_OnLeaveCombat")
RegisterUnitEvent(21416, 4, "Lakaan_OnDied")