--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WebwoodSilkspinner_OnCombat(Unit, Event)
	Unit:RegisterEvent("WebwoodSilkspinner_Web", 8000, 0)
end

function WebwoodSilkspinner_Web(Unit, Event) 
	Unit:FullCastSpellOnTarget(12023, 	Unit:GetMainTank()) 
end

function WebwoodSilkspinner_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WebwoodSilkspinner_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function WebwoodSilkspinner_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2000, 1, "WebwoodSilkspinner_OnCombat")
RegisterUnitEvent(2000, 2, "WebwoodSilkspinner_OnLeaveCombat")
RegisterUnitEvent(2000, 3, "WebwoodSilkspinner_OnKilledTarget")
RegisterUnitEvent(2000, 4, "WebwoodSilkspinner_OnDied")