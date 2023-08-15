function DCHawkeye_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("DCHawkeye_Spell", 32000, 0)
end

function DCHawkeye_Spell(Unit,Event)
	Unit:FullCastSpellOnTarget(37974,Unit:GetClosestPlayer())
end

function DCHawkeye_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function DCHawkeye_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21386, 1, "DCHawkeye_OnEnterCombat")
RegisterUnitEvent(21386, 2, "DCHawkeye_OnLeaveCombat")
RegisterUnitEvent(21386, 4, "DCHawkeye_OnDied")