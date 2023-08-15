function DSmith_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("DSmith_ChaosNova", 6000, 0)
	Unit:RegisterEvent("DSmith_DrillArmor", 6000, 0)
end

function DSmith_ChaosNova(Unit,Event)
	Unit:FullCastSpellOnTarget(36225,Unit:GetClosestPlayer())
end

function DSmith_DrillArmor(Unit,Event)
	Unit:FullCastSpellOnTarget(37580,Unit:GetClosestPlayer())
end

function DSmith_LeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function DSmith_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(19756, 1, "DSmith_OnEnterCombat")
RegisterUnitEvent(19756, 2, "DSmith_LeaveCombat")
RegisterUnitEvent(19756, 4, "DSmith_OnDied")