--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DecrepitNecromancer_OnCombat(Unit, Event)
Unit:RegisterEvent("DecrepitNecromancer_ConversionBeam", 8000, 0)
Unit:RegisterEvent("DecrepitNecromancer_ShadowBolt", 5000, 0)
end

function DecrepitNecromancer_ConversionBeam(Unit, Event) 
Unit:FullCastSpellOnTarget(50659, Unit:GetMainTank()) 
end

function DecrepitNecromancer_ShadowBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(9613, Unit:GetMainTank()) 
end

function DecrepitNecromancer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DecrepitNecromancer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DecrepitNecromancer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26942, 1, "DecrepitNecromancer_OnCombat")
RegisterUnitEvent(26942, 2, "DecrepitNecromancer_OnLeaveCombat")
RegisterUnitEvent(26942, 3, "DecrepitNecromancer_OnKilledTarget")
RegisterUnitEvent(26942, 4, "DecrepitNecromancer_OnDied")