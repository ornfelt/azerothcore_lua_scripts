function ESoldier_OnEnterCombat(Unit,Event)
 if Unit:GetHealthPct() == 3 then
	Unit:CastSpell(36476)
end
end

function ESoldier_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function ESoldier_OnDeath(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(22016, 1, "ESoldier_OnEnterCombat")
RegisterUnitEvent(22016, 2, "ESoldier_OnLeaveCombat")
RegisterUnitEvent(22016, 4, "ESoldier_OnDeath")