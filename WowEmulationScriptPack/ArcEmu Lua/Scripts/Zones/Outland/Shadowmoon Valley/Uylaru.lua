function Uylaru_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Uylaru_CorruptedSearingTotem", 20000, 0)
	Unit:RegisterEvent("Uylaru_FlameShock", 16000, 0)
end

function Uylaru_CorruptedSearingTotem(Unit,Event)
	Unit:FullCastSpellOnTarget(38581,Unit:GetClosestPlayer())
end

function Uylaru_FlameShock(Unit,Event)
	Unit:FullCastSpellOnTarget(15039,Unit:GetClosestPlayer())
end

function Uylaru_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Uylaru_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21710, 1, "Uylaru_OnEnterCombat")
RegisterUnitEvent(21710, 2, "Uylaru_OnLeaveCombat")
RegisterUnitEvent(21710, 4, "Uylaru_OnDied")