--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DrakkariPlagueSpreader_OnCombat(Unit, Event)
Unit:RegisterEvent("DrakkariPlagueSpreader_PlagueInfected", 10000, 0)
end

function DrakkariPlagueSpreader_PlagueInfected(Unit, Event) 
Unit:FullCastSpellOnTarget(52230, Unit:GetMainTank()) 
end

function DrakkariPlagueSpreader_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DrakkariPlagueSpreader_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DrakkariPlagueSpreader_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27941, 1, "DrakkariPlagueSpreader_OnCombat")
RegisterUnitEvent(27941, 2, "DrakkariPlagueSpreader_OnLeaveCombat")
RegisterUnitEvent(27941, 3, "DrakkariPlagueSpreader_OnKilledTarget")
RegisterUnitEvent(27941, 4, "DrakkariPlagueSpreader_OnDied")