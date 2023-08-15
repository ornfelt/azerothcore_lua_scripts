--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function VoodooTroll_OnCombat(Unit, Event)
	Unit:RegisterEvent("VoodooTroll_LightningShield", 5000, 0)
	Unit:RegisterEvent("VoodooTroll_HealingWave", 12000, 0)
end

function VoodooTroll_LightningShield(Unit, Event) 
	Unit:CastSpell(324) 
end

function VoodooTroll_HealingWave(Unit, Event) 
	Unit:CastSpell(332) 
end

function VoodooTroll_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function VoodooTroll_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function VoodooTroll_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3206, 1, "VoodooTroll_OnCombat")
RegisterUnitEvent(3206, 2, "VoodooTroll_OnLeaveCombat")
RegisterUnitEvent(3206, 3, "VoodooTroll_OnKilledTarget")
RegisterUnitEvent(3206, 4, "VoodooTroll_OnDied")