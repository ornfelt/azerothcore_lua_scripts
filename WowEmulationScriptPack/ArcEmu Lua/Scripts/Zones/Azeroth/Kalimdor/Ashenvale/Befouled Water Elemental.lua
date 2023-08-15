--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BefouledWaterElemental_OnCombat(Unit, Event)
	Unit:RegisterEvent("BefouledWaterElemental_FoulChill", 1000, 2)
	Unit:RegisterEvent("BefouledWaterElemental_Frostbolt", 8000, 0)
end

function BefouledWaterElemental_FoulChill(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6873, 	pUnit:GetMainTank()) 
end

function BefouledWaterElemental_Frostbolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9672, 	pUnit:GetMainTank()) 
end

function BefouledWaterElemental_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BefouledWaterElemental_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3917, 1, "BefouledWaterElemental_OnCombat")
RegisterUnitEvent(3917, 2, "BefouledWaterElemental_OnLeaveCombat")
RegisterUnitEvent(3917, 4, "BefouledWaterElemental_OnDied")