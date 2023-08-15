--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SmolderingConstruct_OnCombat(Unit, Event)
Unit:RegisterEvent("SmolderingConstruct_Backlash", 6000, 0)
end

function SmolderingConstruct_Backlash(Unit, Event) 
Unit:FullCastSpellOnTarget(51439, Unit:GetMainTank()) 
end

function SmolderingConstruct_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SmolderingConstruct_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SmolderingConstruct_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27362, 1, "SmolderingConstruct_OnCombat")
RegisterUnitEvent(27362, 2, "SmolderingConstruct_OnLeaveCombat")
RegisterUnitEvent(27362, 3, "SmolderingConstruct_OnKilledTarget")
RegisterUnitEvent(27362, 4, "SmolderingConstruct_OnDied")