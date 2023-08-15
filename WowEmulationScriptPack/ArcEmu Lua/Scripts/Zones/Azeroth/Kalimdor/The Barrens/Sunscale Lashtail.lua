--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SunscaleLashtail_OnCombat(Unit, Event)
	Unit:RegisterEvent("SunscaleLashtail_Lash", 6000, 0)
end

function SunscaleLashtail_Lash(Unit, Event) 
	Unit:FullCastSpellOnTarget(6607, 	Unit:GetMainTank()) 
end

function SunscaleLashtail_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SunscaleLashtail_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function SunscaleLashtail_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3254, 1, "SunscaleLashtail_OnCombat")
RegisterUnitEvent(3254, 2, "SunscaleLashtail_OnLeaveCombat")
RegisterUnitEvent(3254, 3, "SunscaleLashtail_OnKilledTarget")
RegisterUnitEvent(3254, 4, "SunscaleLashtail_OnDied")