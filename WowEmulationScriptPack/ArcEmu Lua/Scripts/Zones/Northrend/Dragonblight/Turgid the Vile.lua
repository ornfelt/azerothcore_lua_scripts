--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TurgidtheVile_OnCombat(Unit, Event)
Unit:RegisterEvent("TurgidtheVile_ScourgeHook", 6000, 0)
Unit:RegisterEvent("TurgidtheVile_VileVommit", 8000, 0)
end

function TurgidtheVile_ScourgeHook(Unit, Event) 
Unit:FullCastSpellOnTarget(50335, Unit:GetMainTank()) 
end

function TurgidtheVile_VileVommit(Unit, Event) 
Unit:FullCastSpellOnTarget(51356, Unit:GetMainTank()) 
end

function TurgidtheVile_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TurgidtheVile_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TurgidtheVile_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27808, 1, "TurgidtheVile_OnCombat")
RegisterUnitEvent(27808, 2, "TurgidtheVile_OnLeaveCombat")
RegisterUnitEvent(27808, 3, "TurgidtheVile_OnKilledTarget")
RegisterUnitEvent(27808, 4, "TurgidtheVile_OnDied")