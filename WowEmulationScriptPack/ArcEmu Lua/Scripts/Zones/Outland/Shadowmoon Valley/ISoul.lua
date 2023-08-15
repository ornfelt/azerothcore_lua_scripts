function ISoul_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("ISoul_Totem", 11000, 0)
end

function ISoul_Totem(Unit,Event)
	Unit:CastSpell(11969)
end

function ISoul_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function ISoul_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(19757, 1, "ISoul_OnEnterCombat")
RegisterUnitEvent(19757, 2, "ISoul_OnLeaveCombat")
RegisterUnitEvent(19757, 4, "ISoul_OnDied")