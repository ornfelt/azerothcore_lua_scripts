function DDrakeRider_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(6660,Unit:GetClosestPlayer())
end

function DDrakeRider_LeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function DDrakeRider_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21719, 1, "DDrakeRider_OnEnterCombat")
RegisterUnitEvent(21719, 2, "DDrakeRider_LeaveCombat")
RegisterUnitEvent(21719, 4, "DDrakeRider_OnDied")