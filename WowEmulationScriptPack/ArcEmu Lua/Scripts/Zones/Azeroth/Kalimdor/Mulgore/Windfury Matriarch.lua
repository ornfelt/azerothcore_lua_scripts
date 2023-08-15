--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WindfuryMatriarch_OnCombat(Unit, Event)
Unit:RegisterEvent("WindfuryMatriarch_LightningBolt", 8000, 0)
Unit:RegisterEvent("WindfuryMatriarch_HealingWave", 15000, 0)
end

function WindfuryMatriarch_LightningBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9532, pUnit:GetClosestPlayer()) 
end

function WindfuryMatriarch_HealingWave(pUnit, Event) 
pUnit:CastSpell(332) 
end

function WindfuryMatriarch_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WindfuryMatriarch_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WindfuryMatriarch_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2965, 1, "WindfuryMatriarch_OnCombat")
RegisterUnitEvent(2965, 2, "WindfuryMatriarch_OnLeaveCombat")
RegisterUnitEvent(2965, 3, "WindfuryMatriarch_OnKilledTarget")
RegisterUnitEvent(2965, 4, "WindfuryMatriarch_OnDied")