function SanctumDefender_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(41440,Unit:GetClosestPlayer())
end

RegisterUnitEvent(23435, 1, "SanctumDefender_OnEnterCombat")