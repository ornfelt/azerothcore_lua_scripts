--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AmbershardDestroyer_OnCombat(Unit, Event)
	Unit:RegisterEvent("AmbershardDestroyer_Boulder", 8000, 0)
	Unit:RegisterEvent("AmbershardDestroyer_EarthShock", 11000, 0)
end

function AmbershardDestroyer_Boulder(Unit, Event) 
	Unit:FullCastSpellOnTarget(19701, 	Unit:GetMainTank()) 
end

function AmbershardDestroyer_EarthShock(Unit, Event) 
	Unit:FullCastSpellOnTarget(13728, 	Unit:GetMainTank()) 
end

function AmbershardDestroyer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function AmbershardDestroyer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(11782, 1, "AmbershardDestroyer_OnCombat")
RegisterUnitEvent(11782, 2, "AmbershardDestroyer_OnLeaveCombat")
RegisterUnitEvent(11782, 4, "AmbershardDestroyer_OnDied")