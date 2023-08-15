function Dimp_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Dimp_Firebolt", 6000, 0)
end

function Dimp_Firebolt(Unit,Event)
	Unit:FullCastSpellOnTarget(36227,Unit:GetClosestPlayer())
end

function Dimp_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

function Dimp_LeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(20887, 1, "Dimp_OnEnterCombat")
RegisterUnitEvent(20887, 2, "Dimp_LeaveCombat")
RegisterUnitEvent(20887, 4, "Dimp_OnDied")