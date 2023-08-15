--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Thassarian_OnCombat(Unit, Event)
Unit:RegisterEvent("Thassarian_EmpoweredBloodPresence", 1000, 1)
end

function Thassarian_EmpoweredBloodPresence(Unit, Event) 
Unit:CastSpell(50995) 
end

function Thassarian_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Thassarian_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Thassarian_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26170, 1, "Thassarian_OnCombat")
RegisterUnitEvent(26170, 2, "Thassarian_OnLeaveCombat")
RegisterUnitEvent(26170, 3, "Thassarian_OnKilledTarget")
RegisterUnitEvent(26170, 4, "Thassarian_OnDied")