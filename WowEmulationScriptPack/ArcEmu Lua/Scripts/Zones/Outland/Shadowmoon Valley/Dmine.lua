function Dmine_OnEnterCombat(Unit,Event)
	Unit:GetMainTank()
	Unit:CastSpell(5)
end

function Dmine_LeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Dmine_OnDied(Unit,Event)
	Unit:FullCastSpellOnTarget(38108,Unit:GetMainTank())
end

RegisterUnitEvent(22315, 2, "Dmine_OnEnterCombat")
RegisterUnitEvent(22315, 2, "Dmine_LeaveCombat")
RegisterUnitEvent(22315, 4, "Dmine_OnDied")