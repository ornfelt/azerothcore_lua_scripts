--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WarsongShredder_OnCombat(Unit, Event)
	Unit:RegisterEvent("WarsongShredder_Overdrive", 10000, 0)
end

function WarsongShredder_Overdrive(pUnit, Event) 
	pUnit:CastSpell(18546) 
end

function WarsongShredder_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WarsongShredder_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(11684, 1, "WarsongShredder_OnCombat")
RegisterUnitEvent(11684, 2, "WarsongShredder_OnLeaveCombat")
RegisterUnitEvent(11684, 4, "WarsongShredder_OnDied")