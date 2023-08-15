--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DemonSpirit_OnCombat(Unit, Event)
	Unit:RegisterEvent("DemonSpirit_SummonedDemon", 5000, 1)
end

function DemonSpirit_SummonedDemon(Unit, Event) 
	Unit:CastSpell(7741) 
end

function DemonSpirit_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DemonSpirit_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(11876, 1, "DemonSpirit_OnCombat")
RegisterUnitEvent(11876, 2, "DemonSpirit_OnLeaveCombat")
RegisterUnitEvent(11876, 4, "DemonSpirit_OnDied")