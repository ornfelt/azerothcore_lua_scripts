function PainmistressGabrissa_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("PainmistressGabrissa_CurseOfPain", 120000, 0)
end

function PainmistressGabrissa_CurseOfPain(Unit,Event)
	Unit:FullCastSpellOnTarget(38048,Unit:GetClosestPlayer())
 if Unit:GetHealthPct() == 50 then 
	Unit:RemoveEvents()
end
end

function PainmistressGabrissa_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function PainmistressGabrissa_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21309, 1, "PainmistressGabrissa_OnEnterCombat")
RegisterUnitEvent(21309, 2, "PainmistressGabrissa_OnLeaveCombat")
RegisterUnitEvent(21309, 4, "PainmistressGabrissa_OnDied")