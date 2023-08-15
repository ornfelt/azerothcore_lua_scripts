function Gromtor_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(26281,Unit:GetClosestPlayer())
	Unit:RegisterEvent("Gromtor_SunderArmor", 120000, 0)
	Unit:RegisterEvent("Gromtor_ShieldWall", 22000, 0)
	Unit:RegisterEvent("Gromtor_ShieldBlock", 40000, 0)
	Unit:RegisterEvent("Gromtor_HeroicStrike", 4000, 0)
	Unit:RegisterEvent("Gromtor_BattleShout", 240000, 0)
end

function Gromtor_SunderArmor(Unit,Event)
	Unit:FullCastSpellOnTarget(16145,Unit:GetClosestPlayer())
end

function Gromtor_ShieldWall(Unit,Event)
	Unit:FullCastSpellOnTarget(15062,Unit:GetClosestPlayer())
end

function Gromtor_ShieldBlock(Unit,Event)
	Unit:FullCastSpellOnTarget(12169,Unit:GetClosestPlayer())
end

function Gromtor_HeroicStrike(Unit,Event)
	Unit:FullCastSpellOnTarget(29426,Unit:GetClosestPlayer())
end

function Gromtor_BattleShout(Unit,Event)
	Unit:FullCastSpellOnTarget(31403,Unit:GetClosestPlayer())
end

function Gromtor_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Gromtor_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21291, 1, "Gromtor_OnEnterCombat")
RegisterUnitEvent(21291, 2, "Gromtor_OnLeaveCombat")
RegisterUnitEvent(21291, 4, "Gromtor_OnDied")