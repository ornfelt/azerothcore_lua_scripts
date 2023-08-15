function LFCannon_OnEnterCombat(Unit,Event)
 if Unit:GetHealthPct() == 70 then
	Unit:FullCastSpellOnTarget(36238,Unit:GetClosestPlayer())
end
end

RegisterUnitEvent(21233, 1, "LFCannon_OnEnterCombat")