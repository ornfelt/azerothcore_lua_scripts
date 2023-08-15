function ZuluhedTheWhacked_OnEnterCombat(Unit,Event)
	Unit:CastSpell(38853)
	Unit:RegisterEvent("ZuluhedTheWhacked_DemonPortal", 35000, 0)
end

function ZuluhedTheWhacked_DemonPortal(Unit,Event)
	Unit:CastSpell(38876)
end

function ZuluhedTheWhacked_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function ZuluhedTheWhacked_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(11980, 1, "ZuluhedTheWhacked_OnEnterCombat")
RegisterUnitEvent(11980, 2, "ZuluhedTheWhacked_OnLeaveCombat")
RegisterUnitEvent(11980, 4, "ZuluhedTheWhacked_OnDied")