function EDemolisher_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("EDemolisher_Stomp", 19000, 0)
end

function EDemolisher_Stomp(Unit,Event)
	Unit:CastSpell(38045)
end

function EDemolisher_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function EDemolisher_OnDeath(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21802, 1, "EDemolisher_OnEnterCombat")
RegisterUnitEvent(21802, 2, "EDemolisher_OnLeaveCombat")
RegisterUnitEvent(21802, 4, "EDemolisher_OnDeath")