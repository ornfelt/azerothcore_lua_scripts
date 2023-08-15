--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SilverbrookDefender_OnCombat(Unit, Event)
Unit:RegisterEvent("SilverbrookDefender_LumberjackSlam", 8000, 0)
Unit:RegisterEvent("SilverbrookDefender_Rend", 10000, 0)
end

function SilverbrookDefender_LumberjackSlam(Unit, Event) 
Unit:FullCastSpellOnTarget(52318, Unit:GetMainTank()) 
end

function SilverbrookDefender_Rend(Unit, Event) 
Unit:FullCastSpellOnTarget(12054, Unit:GetMainTank()) 
end

function SilverbrookDefender_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SilverbrookDefender_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SilverbrookDefender_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27676, 1, "SilverbrookDefender_OnCombat")
RegisterUnitEvent(27676, 2, "SilverbrookDefender_OnLeaveCombat")
RegisterUnitEvent(27676, 3, "SilverbrookDefender_OnKilledTarget")
RegisterUnitEvent(27676, 4, "SilverbrookDefender_OnDied")