function IDreadbringer_OnEnterCombat(Unit,Event)
 if Unit:GetHealthPct() == 91 then
	Unit:FullCastSpellOnTarget(38167,Unit:GetClosestPlayer())
end
end

RegisterUnitEvent(19799, 1, "IDreadbringer_OnEnterCombat")