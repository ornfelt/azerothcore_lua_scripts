--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function RazormaneBattleguard_OnCombat(Unit, Event)
	Unit:RegisterEvent("RazormaneBattleguard_ImprovedBlocking", 8000, 0)
end

function RazormaneBattleguard_ImprovedBlocking(Unit, Event) 
	Unit:CastSpell(3248) 
end

function RazormaneBattleguard_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RazormaneBattleguard_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function RazormaneBattleguard_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3114, 1, "RazormaneBattleguard_OnCombat")
RegisterUnitEvent(3114, 2, "RazormaneBattleguard_OnLeaveCombat")
RegisterUnitEvent(3114, 3, "RazormaneBattleguard_OnKilledTarget")
RegisterUnitEvent(3114, 4, "RazormaneBattleguard_OnDied")