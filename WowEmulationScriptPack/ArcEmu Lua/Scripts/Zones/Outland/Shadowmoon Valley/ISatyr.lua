function ISatyr_OnEnterCombat(Unit,Event)
 if Unit:GetHealthPct() == 97 then
	Unit:FullCastSpellOnTarget(38048,Unit:GetClosestPlayer())
end
end

RegisterUnitEvent(21656, 1, "ISatyr_OnEnterCombat")