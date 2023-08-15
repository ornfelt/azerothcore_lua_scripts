function ValzareqTheConqueror_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Uylaru_Shoot", 2000, 3)
end

function ValzareqTheConqueror_Shoot(Unit,Event)
	Unit:FullCastSpellOnTarget(38094,Unit:GetClosestPlayer())
end

function ValzareqTheConqueror_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function ValzareqTheConqueror_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21979, 1, "ValzareqTheConqueror_OnEnterCombat")
RegisterUnitEvent(21979, 2, "ValzareqTheConqueror_OnLeaveCombat")
RegisterUnitEvent(21979, 4, "ValzareqTheConqueror_OnDied")