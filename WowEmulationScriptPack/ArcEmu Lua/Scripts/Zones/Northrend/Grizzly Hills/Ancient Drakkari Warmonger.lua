--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AncientDrakkariWarmonger_OnCombat(Unit, Event)
Unit:RegisterEvent("AncientDrakkariWarmonger_SunderArmor", 6000, 0)
end

function AncientDrakkariWarmonger_SunderArmor(Unit, Event) 
Unit:FullCastSpellOnTarget(50370, Unit:GetMainTank()) 
end

function AncientDrakkariWarmonger_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AncientDrakkariWarmonger_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AncientDrakkariWarmonger_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26811, 1, "AncientDrakkariWarmonger_OnCombat")
RegisterUnitEvent(26811, 2, "AncientDrakkariWarmonger_OnLeaveCombat")
RegisterUnitEvent(26811, 3, "AncientDrakkariWarmonger_OnKilledTarget")
RegisterUnitEvent(26811, 4, "AncientDrakkariWarmonger_OnDied")