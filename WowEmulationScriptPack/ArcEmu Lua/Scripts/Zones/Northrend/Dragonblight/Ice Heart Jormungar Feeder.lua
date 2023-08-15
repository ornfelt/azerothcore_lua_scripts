--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function IceHeartJormungarFeeder_OnCombat(Unit, Event)
Unit:RegisterEvent("IceHeartJormungarFeeder_CorrosiveSpit", 6000, 1)
end

function IceHeartJormungarFeeder_CorrosiveSpit(Unit, Event) 
Unit:FullCastSpellOnTarget(47447, Unit:GetMainTank()) 
end

function IceHeartJormungarFeeder_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IceHeartJormungarFeeder_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IceHeartJormungarFeeder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26358, 1, "IceHeartJormungarFeeder_OnCombat")
RegisterUnitEvent(26358, 2, "IceHeartJormungarFeeder_OnLeaveCombat")
RegisterUnitEvent(26358, 3, "IceHeartJormungarFeeder_OnKilledTarget")
RegisterUnitEvent(26358, 4, "IceHeartJormungarFeeder_OnDied")