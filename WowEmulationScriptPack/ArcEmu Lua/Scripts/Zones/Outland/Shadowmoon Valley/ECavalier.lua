function ECavalier_OnEnterCombat(Unit,Event)
	Unit:CastSpell(38311)
	Unit:RegisterEvent("ECavalier_SpellBreaker", 20000, 0)
	Unit:RegisterEvent("ECavalier_BattleShout", 60000, 0)
end

function ECavalier_SpellBreaker(Unit,Event)
	Unit:CastSpell(35871)
end

function ECavalier_BattleShout(Unit,Event)
	Unit:CastSpell(30931)
end

function ECavalier_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function ECavalier_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(22018, 1, "ECavalier_OnEnterCombat")
RegisterUnitEvent(22018, 2, "ECavalier_OnLeaveCombat")
RegisterUnitEvent(22018, 4, "ECavalier_OnDied")