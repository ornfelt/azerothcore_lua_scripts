--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function RazorfenThornweaver_OnCombat(Unit, Event)
	Unit:RegisterEvent("RazorfenThornweaver_HealingTouch", 15000, 0)
	Unit:RegisterEvent("RazorfenThornweaver_Thorns", 4000, 1)
end

function RazorfenThornweaver_HealingTouch(Unit, Event) 
	Unit:CastSpell(11431) 
end

function RazorfenThornweaver_Thorns(Unit, Event) 
	Unit:CastSpell(7966) 
end

function RazorfenThornweaver_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RazorfenThornweaver_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function RazorfenThornweaver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(7874, 1, "RazorfenThornweaver_OnCombat")
RegisterUnitEvent(7874, 2, "RazorfenThornweaver_OnLeaveCombat")
RegisterUnitEvent(7874, 3, "RazorfenThornweaver_OnKilledTarget")
RegisterUnitEvent(7874, 4, "RazorfenThornweaver_OnDied")