--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BloodShade_OnCombat(Unit, Event)
Unit:RegisterEvent("BloodShade_VexedBloodoftheAncestors", 6000, 0)
end

function BloodShade_VexedBloodoftheAncestors(Unit, Event) 
Unit:FullCastSpellOnTarget(49843, Unit:GetMainTank()) 
end

function BloodShade_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BloodShade_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BloodShade_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24872, 1, "BloodShade_OnCombat")
RegisterUnitEvent(24872, 2, "BloodShade_OnLeaveCombat")
RegisterUnitEvent(24872, 3, "BloodShade_OnKilledTarget")
RegisterUnitEvent(24872, 4, "BloodShade_OnDied")