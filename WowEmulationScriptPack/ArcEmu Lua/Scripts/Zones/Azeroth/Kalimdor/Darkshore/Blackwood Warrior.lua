--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BlackwoodWarrior_OnCombat(Unit, Event)
	Unit:RegisterEvent("BlackwoodWarrior_BattleStance", 2000, 1)
	Unit:RegisterEvent("BlackwoodWarrior_Thunderclap", 7000, 0)
end

function BlackwoodWarrior_BattleStance(pUnit, Event) 
	pUnit:CastSpell(7165) 
end

function BlackwoodWarrior_Thunderclap(pUnit, Event) 
	pUnit:CastSpell(8078) 
end

function BlackwoodWarrior_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BlackwoodWarrior_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2168, 1, "BlackwoodWarrior_OnCombat")
RegisterUnitEvent(2168, 2, "BlackwoodWarrior_OnLeaveCombat")
RegisterUnitEvent(2168, 3, "BlackwoodWarrior_OnKilledTarget")
RegisterUnitEvent(2168, 4, "BlackwoodWarrior_OnDied")