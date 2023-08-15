--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function StormBayOracle_OnCombat(Unit, Event)
	Unit:RegisterEvent("StormBayOracle_LightningBolt", 8000, 0)
end

function StormBayOracle_LightningBolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9532, 	pUnit:GetMainTank()) 
end

function StormBayOracle_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function StormBayOracle_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6351, 1, "StormBayOracle_OnCombat")
RegisterUnitEvent(6351, 2, "StormBayOracle_OnLeaveCombat")
RegisterUnitEvent(6351, 4, "StormBayOracle_OnDied")