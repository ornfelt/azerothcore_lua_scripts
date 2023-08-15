function ISlayer_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(35570,Unit:GetClosestPlayer())
end

RegisterUnitEvent(21639, 1, "ISlayer_OnEnterCombat")