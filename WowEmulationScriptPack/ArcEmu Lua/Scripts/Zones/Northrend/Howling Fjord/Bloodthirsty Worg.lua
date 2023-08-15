--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BloodthirstyWorg_OnCombat(Unit, Event)
Unit:RegisterEvent("BloodthirstyWorg_InfectedBite", 10000, 0)
end

function BloodthirstyWorg_InfectedBite(Unit, Event) 
Unit:FullCastSpellOnTarget(7367, Unit:GetMainTank()) 
end

function BloodthirstyWorg_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BloodthirstyWorg_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BloodthirstyWorg_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24475, 1, "BloodthirstyWorg_OnCombat")
RegisterUnitEvent(24475, 2, "BloodthirstyWorg_OnLeaveCombat")
RegisterUnitEvent(24475, 3, "BloodthirstyWorg_OnKilledTarget")
RegisterUnitEvent(24475, 4, "BloodthirstyWorg_OnDied")