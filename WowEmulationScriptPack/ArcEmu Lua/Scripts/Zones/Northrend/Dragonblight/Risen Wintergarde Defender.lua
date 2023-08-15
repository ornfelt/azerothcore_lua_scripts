--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function RisenWintergardeDefender_OnCombat(Unit, Event)
Unit:RegisterEvent("RisenWintergardeDefender_UnwaveringWill", 4000, 1)
end

function RisenWintergardeDefender_UnwaveringWill(Unit, Event) 
Unit:CastSpell(51307) 
end

function RisenWintergardeDefender_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RisenWintergardeDefender_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RisenWintergardeDefender_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27284, 1, "RisenWintergardeDefender_OnCombat")
RegisterUnitEvent(27284, 2, "RisenWintergardeDefender_OnLeaveCombat")
RegisterUnitEvent(27284, 3, "RisenWintergardeDefender_OnKilledTarget")
RegisterUnitEvent(27284, 4, "RisenWintergardeDefender_OnDied")