function IWatcher_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("IWatcher_MStrike", 35000, 0)
end

function IWatcher_MStrike(Unit,Event)
	Unit:FullCastSpellOnTarget(32736,Unit:GetClosestPlayer())
end

function IWatcher_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function IWatcher_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(22093, 1, "IWatcher_OnEnterCombat")
RegisterUnitEvent(22093, 2, "IWatcher_OnLeaveCombat")
RegisterUnitEvent(22093, 4, "IWatcher_OnDied")