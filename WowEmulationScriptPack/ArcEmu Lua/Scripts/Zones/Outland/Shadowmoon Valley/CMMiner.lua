function CMMiner_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("CMMiner_Enrage", 5000, 0)
end

function CMMiner_Enrage(Unit,Event)
	Unit:CastSpell(40743)
end

function CMMiner_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function CMMiner_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(23324, 1, "CMMiner_OnEnterCombat")
RegisterUnitEvent(23324, 2, "CMMiner_OnLeaveCombat")
RegisterUnitEvent(23324, 4, "CMMiner_OnDied")