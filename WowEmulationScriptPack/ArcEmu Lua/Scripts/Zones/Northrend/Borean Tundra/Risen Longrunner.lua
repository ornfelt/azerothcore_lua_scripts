--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function RisenLongrunner_OnCombat(Unit, Event)
Unit:RegisterEvent("RisenLongrunner_GhostStrike", 8000, 0)
end

function RisenLongrunner_GhostStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(36093, Unit:GetMainTank()) 
end

function RisenLongrunner_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RisenLongrunner_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RisenLongrunner_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25350, 1, "RisenLongrunner_OnCombat")
RegisterUnitEvent(25350, 2, "RisenLongrunner_OnLeaveCombat")
RegisterUnitEvent(25350, 3, "RisenLongrunner_OnKilledTarget")
RegisterUnitEvent(25350, 4, "RisenLongrunner_OnDied")