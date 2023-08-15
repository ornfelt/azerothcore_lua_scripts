function ScorchshellPincer_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("ScorchshellPincer_BurningPoison", 000, 0)
end

function ScorchshellPincer_BurningPoison(Unit,Event)
	Unit:FullCastSpellOnTarget(15284,Unit:GetClosestPlayer())
end

function ScorchshellPincer_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function ScorchshellPincer_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21864, 1, "ScorchshellPincer_OnEnterCombat")
RegisterUnitEvent(21864, 2, "ScorchshellPincer_OnLeaveCombat")
RegisterUnitEvent(21864, 4, "ScorchshellPincer_OnDied")