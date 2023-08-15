--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function EmeraldonOracle_OnCombat(Unit, Event)
	Unit:RegisterEvent("EmeraldonOracle_Regrowth", 6000, 1)
	Unit:RegisterEvent("EmeraldonOracle_Rejuvenation", 12000, 0)
end

function EmeraldonOracle_Regrowth(pUnit, Event) 
	pUnit:CastSpell(20665) 
end

function EmeraldonOracle_Rejuvenation(pUnit, Event) 
	pUnit:CastSpell(20664) 
end

function EmeraldonOracle_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function EmeraldonOracle_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(12476, 1, "EmeraldonOracle_OnCombat")
RegisterUnitEvent(12476, 2, "EmeraldonOracle_OnLeaveCombat")
RegisterUnitEvent(12476, 4, "EmeraldonOracle_OnDied")