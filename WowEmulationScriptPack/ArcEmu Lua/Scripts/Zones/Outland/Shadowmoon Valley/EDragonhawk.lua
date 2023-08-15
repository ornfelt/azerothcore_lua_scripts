function EDragonhawk_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("EDragonhawk_Firebreath", 18000, 0)
end

function EDragonhawk_Firebreath(Unit,Event)
	Unit:FullCastSpellOnTarget(37985,Unit:GetClosestPlayer())
end

function EDragonhawk_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function EDragonhawk_OnDeath(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(20502, 1, "EDragonhawk_OnEnterCombat")
RegisterUnitEvent(20502, 2, "EDragonhawk_OnLeaveCombat")
RegisterUnitEvent(20502, 4, "EDragonhawk_OnDeath")