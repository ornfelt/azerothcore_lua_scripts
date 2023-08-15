function DCHarbinger_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("DCHarbinger_Spell", 13000, 0)
	Unit:RegisterEvent("DCHarbinger_Heal", 25000, 0)
end

function DCHarbinger_Spell(Unit,Event)
	Unit:FullCastSpelOnTarget(15496,Unit:GetClosestPlayer())
end

function DCHarbinger_Heal(Unit,Event)
	Unit:FullCastSpelOnTarget(16588,Unit:GetRandomFriend())
end

function DCHarbinger_Died(Unit,Event)
	Unit:RemoveEvents()
end

function DCHarbinger_LeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21384, 1, "DCHarbinger_OnEnterCombat")
RegisterUnitEvent(21384, 4, "DCHarbinger_Died")
RegisterUnitEvent(21384, 2, "DCHarbinger_LeaveCombat")