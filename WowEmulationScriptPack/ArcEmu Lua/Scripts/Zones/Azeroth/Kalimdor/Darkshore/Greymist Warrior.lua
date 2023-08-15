--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GreymistWarrior_OnCombat(Unit, Event)
	Unit:RegisterEvent("GreymistWarrior_BattleShout", 2000, 1)
end

function GreymistWarrior_BattleShout(pUnit, Event) 
	pUnit:CastSpell(5242) 
end

function GreymistWarrior_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GreymistWarrior_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2205, 1, "GreymistWarrior_OnCombat")
RegisterUnitEvent(2205, 2, "GreymistWarrior_OnLeaveCombat")
RegisterUnitEvent(2205, 4, "GreymistWarrior_OnDied")