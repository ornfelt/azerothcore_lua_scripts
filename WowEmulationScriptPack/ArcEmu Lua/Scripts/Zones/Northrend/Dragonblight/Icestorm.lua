--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Icestorm_OnCombat(Unit, Event)
Unit:RegisterEvent("Icestorm_FrostBreath", 7000, 0)
end

function Icestorm_FrostBreath(Unit, Event) 
Unit:FullCastSpellOnTarget(47428, Unit:GetMainTank()) 
end

function Icestorm_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Icestorm_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Icestorm_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26287, 1, "Icestorm_OnCombat")
RegisterUnitEvent(26287, 2, "Icestorm_OnLeaveCombat")
RegisterUnitEvent(26287, 3, "Icestorm_OnKilledTarget")
RegisterUnitEvent(26287, 4, "Icestorm_OnDied")