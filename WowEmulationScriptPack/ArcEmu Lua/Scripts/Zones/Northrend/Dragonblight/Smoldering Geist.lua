--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SmolderingGeist_OnCombat(Unit, Event)
Unit:RegisterEvent("SmolderingGeist_BurningBlaze", 6500, 0)
end

function SmolderingGeist_BurningBlaze(Unit, Event) 
Unit:FullCastSpellOnTarget(51500, Unit:GetMainTank()) 
end

function SmolderingGeist_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SmolderingGeist_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SmolderingGeist_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27363, 1, "SmolderingGeist_OnCombat")
RegisterUnitEvent(27363, 2, "SmolderingGeist_OnLeaveCombat")
RegisterUnitEvent(27363, 3, "SmolderingGeist_OnKilledTarget")
RegisterUnitEvent(27363, 4, "SmolderingGeist_OnDied")