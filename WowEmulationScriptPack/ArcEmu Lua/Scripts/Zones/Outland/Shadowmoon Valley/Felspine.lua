function Felspine_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Felspine_FelFlames", 11000, 0)
	Unit:RegisterEvent("Felspine_FlamingWound", 46000, 0)
end

function Felspine_FelFlames(Unit,Event)
	Unit:FullCastSpellOnTarget(38356,Unit:GetClosestPlayer())
end

function Felspine_FlamingWound(Unit,Event)
	Unit:FullCastSpellOnTarget(37941,Unit:GetClosestPlayer())
end

function Felspine_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Felspine_OnDied(Unit,Event)
	Unit:RemoveEvents()
end


RegisterUnitEvent(21897, 1, "Felspine_OnEnterCombat")
RegisterUnitEvent(21897, 2, "Felspine_OnLeaveCombat")
RegisterUnitEvent(21897, 4, "Felspine_OnDied")