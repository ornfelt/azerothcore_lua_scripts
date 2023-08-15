--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function FouledWaterSpirit_OnCombat(Unit, Event)
	Unit:RegisterEvent("FouledWaterSpirit_Bloodbolt", 8000, 0)
	Unit:RegisterEvent("FouledWaterSpirit_BloodmystChill", 2000, 1)
end

function FouledWaterSpirit_Bloodbolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(31281, 	pUnit:GetMainTank()) 
end

function FouledWaterSpirit_BloodmystChill(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(31280, 	pUnit:GetMainTank()) 
end

function FouledWaterSpirit_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function FouledWaterSpirit_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17358, 1, "FouledWaterSpirit_OnCombat")
RegisterUnitEvent(17358, 2, "FouledWaterSpirit_OnLeaveCombat")
RegisterUnitEvent(17358, 4, "FouledWaterSpirit_OnDied")