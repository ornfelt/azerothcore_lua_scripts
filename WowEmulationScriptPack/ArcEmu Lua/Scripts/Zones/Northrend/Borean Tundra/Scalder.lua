--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Scalder_OnCombat(Unit, Event)
Unit:RegisterEvent("Scalder_ScaldingBlast", 8000, 0)
Unit:RegisterEvent("Scalder_WaterBolt", 5500, 0)
end

function Scalder_ScaldingBlast(Unit, Event) 
Unit:FullCastSpellOnTarget(50257, Unit:GetMainTank()) 
end

function Scalder_WaterBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(32011, Unit:GetMainTank()) 
end

function Scalder_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Scalder_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Scalder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25226, 1, "Scalder_OnCombat")
RegisterUnitEvent(25226, 2, "Scalder_OnLeaveCombat")
RegisterUnitEvent(25226, 3, "Scalder_OnKilledTarget")
RegisterUnitEvent(25226, 4, "Scalder_OnDied")