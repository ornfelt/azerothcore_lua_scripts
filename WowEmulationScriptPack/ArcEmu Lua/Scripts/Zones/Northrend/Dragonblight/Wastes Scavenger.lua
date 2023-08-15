--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WastesScavenger_OnCombat(Unit, Event)
Unit:RegisterEvent("WastesScavenger_BoneToss", 5000, 0)
end

function WastesScavenger_BoneToss(Unit, Event) 
Unit:FullCastSpellOnTarget(50403, Unit:GetMainTank()) 
end

function WastesScavenger_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WastesScavenger_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WastesScavenger_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(28005, 1, "WastesScavenger_OnCombat")
RegisterUnitEvent(28005, 2, "WastesScavenger_OnLeaveCombat")
RegisterUnitEvent(28005, 3, "WastesScavenger_OnKilledTarget")
RegisterUnitEvent(28005, 4, "WastesScavenger_OnDied")