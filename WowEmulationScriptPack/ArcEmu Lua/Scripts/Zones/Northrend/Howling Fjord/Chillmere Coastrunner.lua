--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ChillmereCoastrunner_OnCombat(Unit, Event)
Unit:RegisterEvent("ChillmereCoastrunner_InstantPoison", 8000, 0)
Unit:RegisterEvent("ChillmereCoastrunner_Rupture", 10000, 0)
end

function ChillmereCoastrunner_InstantPoison(Unit, Event) 
Unit:FullCastSpellOnTarget(28428, Unit:GetMainTank()) 
end

function ChillmereCoastrunner_Rupture(Unit, Event) 
Unit:FullCastSpellOnTarget(14874, Unit:GetMainTank()) 
end

function ChillmereCoastrunner_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ChillmereCoastrunner_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ChillmereCoastrunner_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24459, 1, "ChillmereCoastrunner_OnCombat")
RegisterUnitEvent(24459, 2, "ChillmereCoastrunner_OnLeaveCombat")
RegisterUnitEvent(24459, 3, "ChillmereCoastrunner_OnKilledTarget")
RegisterUnitEvent(24459, 4, "ChillmereCoastrunner_OnDied")