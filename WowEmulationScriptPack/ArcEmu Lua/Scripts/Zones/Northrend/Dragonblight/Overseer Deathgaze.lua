--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function OverseerDeathgaze_OnCombat(Unit, Event)
Unit:RegisterEvent("OverseerDeathgaze_ConversionBeam", 9100, 0)
Unit:RegisterEvent("OverseerDeathgaze_ShadowBolt", 6000, 0)
end

function OverseerDeathgaze_ConversionBeam(Unit, Event) 
Unit:FullCastSpellOnTarget(50659, Unit:GetMainTank()) 
end

function OverseerDeathgaze_ShadowBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(12739, Unit:GetMainTank()) 
end

function OverseerDeathgaze_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OverseerDeathgaze_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OverseerDeathgaze_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27122, 1, "OverseerDeathgaze_OnCombat")
RegisterUnitEvent(27122, 2, "OverseerDeathgaze_OnLeaveCombat")
RegisterUnitEvent(27122, 3, "OverseerDeathgaze_OnKilledTarget")
RegisterUnitEvent(27122, 4, "OverseerDeathgaze_OnDied")