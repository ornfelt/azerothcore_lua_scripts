--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function RazormaneDustrunner_OnCombat(Unit, Event)
	Unit:RegisterEvent("RazormaneDustrunner_FaerieFire", 2000, 2)
	Unit:RegisterEvent("RazormaneDustrunner_Rejuvenation", 12000, 0)
end

function RazormaneDustrunner_FaerieFire(Unit, Event) 
	Unit:FullCastSpellOnTarget(6950, 	Unit:GetMainTank()) 
end

function RazormaneDustrunner_Rejuvenation(Unit, Event) 
	Unit:CastSpell(774) 
end

function RazormaneDustrunner_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RazormaneDustrunner_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function RazormaneDustrunner_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3113, 1, "RazormaneDustrunner_OnCombat")
RegisterUnitEvent(3113, 2, "RazormaneDustrunner_OnLeaveCombat")
RegisterUnitEvent(3113, 3, "RazormaneDustrunner_OnKilledTarget")
RegisterUnitEvent(3113, 4, "RazormaneDustrunner_OnDied")