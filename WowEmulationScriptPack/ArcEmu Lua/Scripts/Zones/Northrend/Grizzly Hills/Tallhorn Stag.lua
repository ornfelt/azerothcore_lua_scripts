--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TallhornStag_OnCombat(Unit, Event)
Unit:RegisterEvent("TallhornStag_Gore", 10000, 0)
end

function TallhornStag_Gore(Unit, Event) 
Unit:FullCastSpellOnTarget(32019, Unit:GetMainTank()) 
end

function TallhornStag_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TallhornStag_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TallhornStag_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26363, 1, "TallhornStag_OnCombat")
RegisterUnitEvent(26363, 2, "TallhornStag_OnLeaveCombat")
RegisterUnitEvent(26363, 3, "TallhornStag_OnKilledTarget")
RegisterUnitEvent(26363, 4, "TallhornStag_OnDied")