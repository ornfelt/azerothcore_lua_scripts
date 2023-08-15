--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AncientDrakkariSoothsayer_OnCombat(Unit, Event)
Unit:RegisterEvent("AncientDrakkariSoothsayer_HolySmite", 5000, 0)
Unit:RegisterEvent("AncientDrakkariSoothsayer_ProphecyofBlood", 9000, 0)
end

function AncientDrakkariSoothsayer_HolySmite(Unit, Event) 
Unit:FullCastSpellOnTarget(9734, Unit:GetMainTank()) 
end

function AncientDrakkariSoothsayer_ProphecyofBlood(Unit, Event) 
Unit:FullCastSpellOnTarget(52468, Unit:GetMainTank()) 
end

function AncientDrakkariSoothsayer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AncientDrakkariSoothsayer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AncientDrakkariSoothsayer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26812, 1, "AncientDrakkariSoothsayer_OnCombat")
RegisterUnitEvent(26812, 2, "AncientDrakkariSoothsayer_OnLeaveCombat")
RegisterUnitEvent(26812, 3, "AncientDrakkariSoothsayer_OnKilledTarget")
RegisterUnitEvent(26812, 4, "AncientDrakkariSoothsayer_OnDied")