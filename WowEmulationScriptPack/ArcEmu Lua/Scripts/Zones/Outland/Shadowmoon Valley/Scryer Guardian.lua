function ScryerGuardian_OnEnterCombat(Unit,Event)
	Unit:registerEvent("ScryerGuardian_Fireball", 7000, 0)
	Unit:registerEvent("ScryerGuardian_Scorch", 5000, 0)
	Unit:registerEvent("ScryerGuardian_Slow", 40000, 0)
end

function ScryerGuardian_Fireball(Unit,Event)
	Unit:FullCastSpellOnTarget(15228,Unit:GetClosestPlayer())
end

function ScryerGuardian_Scorch(Unit,Event)
	Unit:FullCastSpellOnTarget(17195,Unit:GetClosestPlayer())
end

function ScryerGuardian_Slow(Unit,Event)
	Unit:FullCastSpellOnTarget(11436,Unit:GetClosestPlayer())
end

function ScryerGuardian_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function ScryerGuardian_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(19504, 1, "ScryerGuardian_OnEnterCombat")
RegisterUnitEvent(19504, 2, "ScryerGuardian_OnLeaveCombat")
RegisterUnitEvent(19504, 4, "ScryerGuardian_OnDied")