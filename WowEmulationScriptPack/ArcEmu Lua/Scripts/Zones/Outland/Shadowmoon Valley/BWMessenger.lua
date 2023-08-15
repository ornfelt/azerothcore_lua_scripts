function BWMessenger_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(35570,Unit:GetClosestPlayer())
end

RegisterUnitEvent(21244, 1, "BWMessenger_OnEnterCombat")