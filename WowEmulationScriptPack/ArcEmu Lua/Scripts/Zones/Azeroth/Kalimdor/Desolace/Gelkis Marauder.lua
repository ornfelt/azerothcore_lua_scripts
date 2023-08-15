--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GelkisMarauder_OnCombat(Unit, Event)
	Unit:RegisterEvent("GelkisMarauder_BerserkerStance", 3000, 1)
	Unit:RegisterEvent("GelkisMarauder_Cleave", 8000, 0)
end

function GelkisMarauder_BerserkerStance(Unit, Event) 
	Unit:CastSpell(7366) 
end

function GelkisMarauder_Cleave(Unit, Event) 
	Unit:CastSpell(845) 
end

function GelkisMarauder_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GelkisMarauder_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function GelkisMarauder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4653, 1, "GelkisMarauder_OnCombat")
RegisterUnitEvent(4653, 2, "GelkisMarauder_OnLeaveCombat")
RegisterUnitEvent(4653, 3, "GelkisMarauder_OnKilledTarget")
RegisterUnitEvent(4653, 4, "GelkisMarauder_OnDied")