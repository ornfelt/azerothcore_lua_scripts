--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function NorthseaMercenary_OnCombat(Unit, Event)
Unit:RegisterEvent("NorthseaMercenary_Crazed", 5000, 1)
end

function NorthseaMercenary_Crazed(Unit, Event) 
Unit:CastSpell(5915) 
end

function NorthseaMercenary_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NorthseaMercenary_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NorthseaMercenary_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25839, 1, "NorthseaMercenary_OnCombat")
RegisterUnitEvent(25839, 2, "NorthseaMercenary_OnLeaveCombat")
RegisterUnitEvent(25839, 3, "NorthseaMercenary_OnKilledTarget")
RegisterUnitEvent(25839, 4, "NorthseaMercenary_OnDied")