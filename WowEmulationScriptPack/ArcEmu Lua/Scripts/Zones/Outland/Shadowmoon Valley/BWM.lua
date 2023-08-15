function BWM_OnEnterCombat(Unit,Event)
	Unit:RegisterUnitEvent("BWM_SnapKick", 10000, 0)
end

function BWM_SnapKick(Unit,Event)
	Unit:FullCastSpellOnTarget(39477,Unit:GetClosestPlayer())
end

function BWM_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function BWM_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21245, 1, "BWM_OnEnterCombat")
RegisterUnitEvent(21245, 2, "BWM_OnLeaveCombat")
RegisterUnitEvent(21245, 4, "BWM_OnDied")