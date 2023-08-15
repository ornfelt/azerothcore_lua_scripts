--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DarkStrandEnforcer_OnCombat(Unit, Event)
	Unit:RegisterEvent("DarkStrandEnforcer_Enrage", 10000, 0)
end

function DarkStrandEnforcer_Enrage(pUnit, Event) 
	pUnit:CastSpell(8599) 
end

function DarkStrandEnforcer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DarkStrandEnforcer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3727, 1, "DarkStrandEnforcer_OnCombat")
RegisterUnitEvent(3727, 2, "DarkStrandEnforcer_OnLeaveCombat")
RegisterUnitEvent(3727, 4, "DarkStrandEnforcer_OnDied")