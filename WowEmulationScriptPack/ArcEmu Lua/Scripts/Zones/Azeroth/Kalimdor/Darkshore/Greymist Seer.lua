--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GreymistSeer_OnCombat(Unit, Event)
	Unit:RegisterEvent("GreymistSeer_HealingWave", 13000, 0)
	Unit:RegisterEvent("GreymistSeer_LightningShield", 5000, 0)
end

function GreymistSeer_HealingWave(pUnit, Event) 
	pUnit:CastSpell(547) 
end

function GreymistSeer_LightningShield(pUnit, Event) 
	pUnit:CastSpell(324) 
end

function GreymistSeer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GreymistSeer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2203, 1, "GreymistSeer_OnCombat")
RegisterUnitEvent(2203, 2, "GreymistSeer_OnLeaveCombat")
RegisterUnitEvent(2203, 4, "GreymistSeer_OnDied")