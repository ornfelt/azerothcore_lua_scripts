--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Sarendryana_OnCombat(Unit, Event)
Unit:RegisterEvent("Sarendryana_FrostShock", 6000, 0)
end

function Sarendryana_FrostShock(Unit, Event) 
Unit:FullCastSpellOnTarget(12548, Unit:GetMainTank()) 
end

function Sarendryana_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Sarendryana_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Sarendryana_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26837, 1, "Sarendryana_OnCombat")
RegisterUnitEvent(26837, 2, "Sarendryana_OnLeaveCombat")
RegisterUnitEvent(26837, 3, "Sarendryana_OnKilledTarget")
RegisterUnitEvent(26837, 4, "Sarendryana_OnDied")