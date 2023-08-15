--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function PlaguedScavengerr_OnCombat(Unit, Event)
Unit:RegisterEvent("PlaguedScavengerr_InfectedBite", 10000, 0)
end

function PlaguedScavengerr_InfectedBite(Unit, Event) 
Unit:FullCastSpellOnTarget(49861, Unit:GetMainTank()) 
end

function PlaguedScavengerr_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function PlaguedScavengerr_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function PlaguedScavengerr_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25650, 1, "PlaguedScavengerr_OnCombat")
RegisterUnitEvent(25650, 2, "PlaguedScavengerr_OnLeaveCombat")
RegisterUnitEvent(25650, 3, "PlaguedScavengerr_OnKilledTarget")
RegisterUnitEvent(25650, 4, "PlaguedScavengerr_OnDied")