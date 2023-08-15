--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function RazormaneSeer_OnCombat(Unit, Event)
	Unit:RegisterEvent("RazormaneSeer_HealingWard", 2000, 1)
	Unit:RegisterEvent("RazormaneSeer_SearingTotem", 4000, 1)
end

function RazormaneSeer_HealingWard(Unit, Event) 
	Unit:CastSpell(6274) 
end

function RazormaneSeer_SearingTotem(Unit, Event) 
	Unit:CastSpell(6363) 
end

function RazormaneSeer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RazormaneSeer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function RazormaneSeer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3458, 1, "RazormaneSeer_OnCombat")
RegisterUnitEvent(3458, 2, "RazormaneSeer_OnLeaveCombat")
RegisterUnitEvent(3458, 3, "RazormaneSeer_OnKilledTarget")
RegisterUnitEvent(3458, 4, "RazormaneSeer_OnDied")