--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ShadethicketWoodShaper_OnCombat(Unit, Event)
	Unit:RegisterEvent("ShadethicketWoodShaper_EntanglingRoots", 8000, 0)
end

function ShadethicketWoodShaper_EntanglingRoots(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12747, 	pUnit:GetMainTank()) 
end

function ShadethicketWoodShaper_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ShadethicketWoodShaper_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3781, 1, "ShadethicketWoodShaper_OnCombat")
RegisterUnitEvent(3781, 2, "ShadethicketWoodShaper_OnLeaveCombat")
RegisterUnitEvent(3781, 4, "ShadethicketWoodShaper_OnDied")