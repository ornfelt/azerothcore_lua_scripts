--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ThunderhawkHatchling_OnCombat(Unit, Event)
	Unit:RegisterEvent("ThunderhawkHatchling_LightningShield", 4000, 0)
	Unit:RegisterEvent("ThunderhawkHatchling_LightningBolt", 8000, 0)
end

function ThunderhawkHatchling_LightningBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(9532, 	Unit:GetMainTank()) 
end

function ThunderhawkHatchling_LightningShield(Unit, Event) 
	Unit:CastSpell(325) 
end

function ThunderhawkHatchling_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ThunderhawkHatchling_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function ThunderhawkHatchling_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3247, 1, "ThunderhawkHatchling_OnCombat")
RegisterUnitEvent(3247, 2, "ThunderhawkHatchling_OnLeaveCombat")
RegisterUnitEvent(3247, 3, "ThunderhawkHatchling_OnKilledTarget")
RegisterUnitEvent(3247, 4, "ThunderhawkHatchling_OnDied")