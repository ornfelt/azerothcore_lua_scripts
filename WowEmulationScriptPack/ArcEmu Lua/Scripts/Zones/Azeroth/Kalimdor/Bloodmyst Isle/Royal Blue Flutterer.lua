--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function RoyalBlueFlutterer_OnCombat(Unit, Event)
	Unit:RegisterEvent("RoyalBlueFlutterer_Rake", 8000, 0)
end

function RoyalBlueFlutterer_Rake(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(36332, 	pUnit:GetMainTank()) 
end

function RoyalBlueFlutterer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RoyalBlueFlutterer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17350, 1, "RoyalBlueFlutterer_OnCombat")
RegisterUnitEvent(17350, 2, "RoyalBlueFlutterer_OnLeaveCombat")
RegisterUnitEvent(17350, 4, "RoyalBlueFlutterer_OnDied")