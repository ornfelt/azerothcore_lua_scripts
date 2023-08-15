--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function StormscaleWarrior_OnCombat(Unit, Event)
	Unit:RegisterEvent("StormscaleWarrior_ImprovedBlocking", 8000, 0)
end

function StormscaleWarrior_ImprovedBlocking(pUnit, Event) 
	pUnit:CastSpell(3248) 
end

function StormscaleWarrior_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function StormscaleWarrior_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2183, 1, "StormscaleWarrior_OnCombat")
RegisterUnitEvent(2183, 2, "StormscaleWarrior_OnLeaveCombat")
RegisterUnitEvent(2183, 4, "StormscaleWarrior_OnDied")