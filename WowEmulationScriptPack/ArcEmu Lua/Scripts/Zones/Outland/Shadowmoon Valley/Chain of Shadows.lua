function ChainOfShadows_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("ChainOfShadows_Spell", 5500, 0)
end

function ChainOfShadows_Spell(Unit,Event)
	Unit:FullCastSPellOnTarget(37784,Unit:GetClosestPlayer())
end

function ChainOfShadows_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function ChainOfShadows_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21876, 1, "ChainOfShadows_OnEnterCombat")
RegisterUnitEvent(21876, 2, "ChainOfShadows_OnLeaveCombat")
RegisterUnitEvent(21876, 4, "ChainOfShadows_OnDied")