function CMForeman_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("CMForeman_Enrage", 5000, 0)
end

function CMForeman_Enrage(Unit,Event)
	Unit:CastSpell(40743)
end

function CMForeman_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function CMForeman_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(23305, 1, "CMForeman_OnEnterCombat")
RegisterUnitEvent(23305, 2, "CMForeman_OnLeaveCombat")
RegisterUnitEvent(23305, 4, "CMForeman_OnDied")