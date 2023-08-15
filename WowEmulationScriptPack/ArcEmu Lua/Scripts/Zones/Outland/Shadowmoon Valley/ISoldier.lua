function ISoldier_OnEnterCombat(Unit,Event)
 if Unit:GetHealthPct() == 92 then
	Unit:FullCastSpellOnTarget(35871,Unit:GetClosestPlayer())
end
end

RegisterUnitEvent(22075, 1, "ISoldier_OnEnterCombat")