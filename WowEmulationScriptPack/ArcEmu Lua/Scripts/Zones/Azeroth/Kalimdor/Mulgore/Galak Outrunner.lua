--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GalakOutrunner_OnCombat(Unit, Event)
Unit:RegisterEvent("GalakOutrunner_Shot", 6000, 0)
end

function GalakOutrunner_Shot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(6660, pUnit:GetMainTank()) 
end

function GalakOutrunner_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GalakOutrunner_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GalakOutrunner_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2968, 1, "GalakOutrunner_OnCombat")
RegisterUnitEvent(2968, 2, "GalakOutrunner_OnLeaveCombat")
RegisterUnitEvent(2968, 3, "GalakOutrunner_OnKilledTarget")
RegisterUnitEvent(2968, 4, "GalakOutrunner_OnDied")