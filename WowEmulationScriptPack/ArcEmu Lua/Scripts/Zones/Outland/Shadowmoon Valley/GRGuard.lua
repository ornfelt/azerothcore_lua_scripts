function GRGuard_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(38182,Unit:GetClosestPlayer())
end

RegisterUnitEvent(15241, 1, "GRGuard_OnEnterCombat")