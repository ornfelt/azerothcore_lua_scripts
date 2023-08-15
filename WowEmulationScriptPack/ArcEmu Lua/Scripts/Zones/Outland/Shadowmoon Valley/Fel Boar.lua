function FelBoar_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(35570,Unit:GetClosestPlayer())
end

RegisterUnitEvent(21878, 1, "FelBoar_OnEnterCombat")