--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SunscaleScytheclaw_OnCombat(Unit, Event)
	Unit:RegisterEvent("SunscaleScytheclaw_Thrash", 6000, 0)
end

function SunscaleScytheclaw_Thrash(Unit, Event) 
	Unit:FullCastSpellOnTarget(3391, 	Unit:GetMainTank()) 
end

function SunscaleScytheclaw_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SunscaleScytheclaw_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function SunscaleScytheclaw_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3256, 1, "SunscaleScytheclaw_OnCombat")
RegisterUnitEvent(3256, 2, "SunscaleScytheclaw_OnLeaveCombat")
RegisterUnitEvent(3256, 3, "SunscaleScytheclaw_OnKilledTarget")
RegisterUnitEvent(3256, 4, "SunscaleScytheclaw_OnDied")