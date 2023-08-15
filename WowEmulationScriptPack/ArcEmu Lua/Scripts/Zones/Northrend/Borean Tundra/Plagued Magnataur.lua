--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function PlaguedMagnataur_OnCombat(Unit, Event)
Unit:RegisterEvent("PlaguedMagnataur_PlagueCloud", 2000, 2)
end

function PlaguedMagnataur_PlagueCloud(Unit, Event) 
Unit:CastSpell(50366) 
end

function PlaguedMagnataur_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function PlaguedMagnataur_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function PlaguedMagnataur_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25615, 1, "PlaguedMagnataur_OnCombat")
RegisterUnitEvent(25615, 2, "PlaguedMagnataur_OnLeaveCombat")
RegisterUnitEvent(25615, 3, "PlaguedMagnataur_OnKilledTarget")
RegisterUnitEvent(25615, 4, "PlaguedMagnataur_OnDied")