--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ReanimatedDrakkariTribesman_OnCombat(Unit, Event)
Unit:RegisterEvent("ReanimatedDrakkariTribesman_Cannibalize", 10000, 0)
Unit:RegisterEvent("ReanimatedDrakkariTribesman_CrazedHunger", 6000, 0)
end

function ReanimatedDrakkariTribesman_Cannibalize(Unit, Event) 
Unit:CastSpell(50642) 
end

function ReanimatedDrakkariTribesman_CrazedHunger(Unit, Event) 
Unit:CastSpell(3151) 
end

function ReanimatedDrakkariTribesman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ReanimatedDrakkariTribesman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ReanimatedDrakkariTribesman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26946, 1, "ReanimatedDrakkariTribesman_OnCombat")
RegisterUnitEvent(26946, 2, "ReanimatedDrakkariTribesman_OnLeaveCombat")
RegisterUnitEvent(26946, 3, "ReanimatedDrakkariTribesman_OnKilledTarget")
RegisterUnitEvent(26946, 4, "ReanimatedDrakkariTribesman_OnDied")