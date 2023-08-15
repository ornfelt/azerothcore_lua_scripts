function IJailor_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("IJailor_FelShackles", 24000, 0)
end

function IJailor_FelShackles(Unit,Event)
	Unit:FullCastSpellOnTarget(38051,Unit:GetClosestPlayer())
end

function IJailor_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function IJailor_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21520, 1, "IJailor_OnEnterCombat")
RegisterUnitEvent(21520, 2, "IJailor_OnLeaveCombat")
RegisterUnitEvent(21520, 4, "IJailor_OnDied")