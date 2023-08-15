function CMuckwatcher_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("CMuckwatcher_BattleShout", 40000, 0)
end

function CMuckwatcher_BattleShout(Unit,Event)
	Unit:CastSpell(38232)
end

function CMuckwatcher_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function CMuckwatcher_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(19788, 1, "CMuckwatcher_OnEnterCombat")
RegisterUnitEvent(19788, 2, "CMuckwatcher_OnLeaveCombat")
RegisterUnitEvent(19788, 4, "CMuckwatcher_OnDied")