function Karsius_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(37789,Unit:GetClosestPlayer())
end

function Karsius_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Karsius_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21877, 1, "Karsius_OnEnterCombat")
RegisterUnitEvent(21877, 2, "Karsius_OnLeaveCombat")
RegisterUnitEvent(21877, 4, "Karsius_OnDied")