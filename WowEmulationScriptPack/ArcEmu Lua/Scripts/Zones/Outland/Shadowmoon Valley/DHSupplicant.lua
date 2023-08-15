function DHSupplicant_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("DHSupplicant_Spell", 40000, 0)
end

function DHSupplicant_Spell(Unit,Event)
	Unit:CastSpell(37683)
end

function DHSupplicant_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

function DHSupplicant_LeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21179, 1, "DHSupplicant_OnEnterCombat")
RegisterUnitEvent(21179, 2, "DHSupplicant_LeaveCombat")
RegisterUnitEvent(21179, 4, "DHSupplicant_OnDied")