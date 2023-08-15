--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ElderTimberling_OnCombat(Unit, Event)
	Unit:RegisterEvent("ElderTimberling_HealingWave", 12000, 0)
	Unit:RegisterEvent("ElderTimberling_LightningShield", 4000, 0)
end

function ElderTimberling_HealingWave(Unit, Event) 
	Unit:CastSpell(332) 
end

function ElderTimberling_LightningShield(Unit, Event) 
	Unit:CastSpell(324) 
end

function ElderTimberling_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents()
end

function ElderTimberling_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ElderTimberling_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end



RegisterUnitEvent(2030, 1, "ElderTimberling_OnCombat")
RegisterUnitEvent(2030, 2, "ElderTimberling_OnLeaveCombat")
RegisterUnitEvent(2030, 3, "ElderTimberling_OnKilledTarget")
RegisterUnitEvent(2030, 4, "ElderTimberling_OnDied")