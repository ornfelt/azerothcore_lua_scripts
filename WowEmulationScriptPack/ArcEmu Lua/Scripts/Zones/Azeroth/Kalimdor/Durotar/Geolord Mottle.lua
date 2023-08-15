--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GeolordMottle_OnCombat(Unit, Event)
	Unit:RegisterEvent("GeolordMottle_LightningShield", 5000, 0)
	Unit:RegisterEvent("GeolordMottle_HealingWave", 12000, 0)
end

function GeolordMottle_LightningShield(Unit, Event) 
	Unit:CastSpell(324) 
end

function GeolordMottle_HealingWave(Unit, Event) 
	Unit:CastSpell(547) 
end

function GeolordMottle_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GeolordMottle_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function GeolordMottle_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5826, 1, "GeolordMottle_OnCombat")
RegisterUnitEvent(5826, 2, "GeolordMottle_OnLeaveCombat")
RegisterUnitEvent(5826, 3, "GeolordMottle_OnKilledTarget")
RegisterUnitEvent(5826, 4, "GeolordMottle_OnDied")