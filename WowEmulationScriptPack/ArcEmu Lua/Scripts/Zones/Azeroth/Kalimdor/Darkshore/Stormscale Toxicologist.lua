--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function StormscaleToxicologist_OnCombat(Unit, Event)
	Unit:RegisterEvent("StormscaleToxicologist_HolySmite", 8000, 0)
end

function StormscaleToxicologist_HolySmite(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9734, 	pUnit:GetMainTank()) 
end

function StormscaleToxicologist_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function StormscaleToxicologist_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(12321, 1, "StormscaleToxicologist_OnCombat")
RegisterUnitEvent(12321, 2, "StormscaleToxicologist_OnLeaveCombat")
RegisterUnitEvent(12321, 4, "StormscaleToxicologist_OnDied")