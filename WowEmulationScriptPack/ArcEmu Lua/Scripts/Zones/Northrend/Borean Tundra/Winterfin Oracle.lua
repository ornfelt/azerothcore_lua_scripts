--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WinterfinOracle_OnCombat(Unit, Event)
Unit:RegisterEvent("WinterfinOracle_LightningBolt", 8000, 0)
Unit:RegisterEvent("WinterfinOracle_UnstableMagic", 2000, 1)
end

function WinterfinOracle_LightningBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(9532, Unit:GetMainTank()) 
end

function WinterfinOracle_UnstableMagic(Unit, Event) 
Unit:CastSpell(50272) 
end

function WinterfinOracle_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WinterfinOracle_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WinterfinOracle_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25216, 1, "WinterfinOracle_OnCombat")
RegisterUnitEvent(25216, 2, "WinterfinOracle_OnLeaveCombat")
RegisterUnitEvent(25216, 3, "WinterfinOracle_OnKilledTarget")
RegisterUnitEvent(25216, 4, "WinterfinOracle_OnDied")