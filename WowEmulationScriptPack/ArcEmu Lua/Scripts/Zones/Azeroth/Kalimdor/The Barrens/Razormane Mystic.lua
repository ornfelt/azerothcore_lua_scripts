--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function RazormaneMystic_OnCombat(Unit, Event)
	Unit:RegisterEvent("RazormaneMystic_HealingWave", 12000, 0)
	Unit:RegisterEvent("RazormaneMystic_LightningShield", 3000, 0)
end

function RazormaneMystic_HealingWave(Unit, Event) 
	Unit:CastSpell(547) 
end

function RazormaneMystic_LightningShield(Unit, Event) 
	Unit:CastSpell(324) 
end

function RazormaneMystic_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RazormaneMystic_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function RazormaneMystic_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3271, 1, "RazormaneMystic_OnCombat")
RegisterUnitEvent(3271, 2, "RazormaneMystic_OnLeaveCombat")
RegisterUnitEvent(3271, 3, "RazormaneMystic_OnKilledTarget")
RegisterUnitEvent(3271, 4, "RazormaneMystic_OnDied")