--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function RazorfenBattleguard_OnCombat(Unit, Event)
	Unit:RegisterEvent("RazorfenBattleguard_Slam", 6000, 0)
end

function RazorfenBattleguard_Slam(Unit, Event) 
	Unit:FullCastSpellOnTarget(11430, 	Unit:GetMainTank()) 
end

function RazorfenBattleguard_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RazorfenBattleguard_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function RazorfenBattleguard_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(7873, 1, "RazorfenBattleguard_OnCombat")
RegisterUnitEvent(7873, 2, "RazorfenBattleguard_OnLeaveCombat")
RegisterUnitEvent(7873, 3, "RazorfenBattleguard_OnKilledTarget")
RegisterUnitEvent(7873, 4, "RazorfenBattleguard_OnDied")