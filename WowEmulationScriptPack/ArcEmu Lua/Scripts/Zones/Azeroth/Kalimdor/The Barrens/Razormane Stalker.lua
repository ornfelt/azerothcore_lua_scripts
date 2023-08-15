--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function RazormaneStalker_OnCombat(Unit, Event)
	Unit:RegisterEvent("RazormaneStalker_SinesterStrike", 3000, 0)
end

function RazormaneStalker_SinesterStrike(Unit, Event) 
	Unit:FullCastSpellOnTarget(1758, 	Unit:GetMainTank()) 
end

function RazormaneStalker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RazormaneStalker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function RazormaneStalker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3457, 1, "RazormaneStalker_OnCombat")
RegisterUnitEvent(3457, 2, "RazormaneStalker_OnLeaveCombat")
RegisterUnitEvent(3457, 3, "RazormaneStalker_OnKilledTarget")
RegisterUnitEvent(3457, 4, "RazormaneStalker_OnDied")