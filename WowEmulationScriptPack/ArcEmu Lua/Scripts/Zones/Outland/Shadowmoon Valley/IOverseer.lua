function IOverseer_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("IOverseer_MortalStrike", 20000, 0)
	Unit:RegisterEvent("IOverseer_Rend", 50000, 0)
end

function IOverseer_MortalStrike(Unit,Event)
	Unit:FullCastSpellOnTarget(32736,Unit:GetClosestPlayer())
end

function IOverseer_Rend(Unit,Event)
	Unit:FullCastSpellOnTarget(11977,Unit:GetClosestPlayer())
end

function IOverseer_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function IOverseer_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21808, 1, "IOverseer_OnEnterCombat")
RegisterUnitEvent(21808, 2, "IOverseer_OnLeaveCombat")
RegisterUnitEvent(21808, 4, "IOverseer_OnDied")