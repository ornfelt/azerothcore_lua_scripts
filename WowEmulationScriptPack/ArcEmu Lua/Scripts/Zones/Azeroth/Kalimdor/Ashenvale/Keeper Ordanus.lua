--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function KeeperOrdanus_OnCombat(Unit, Event)
	Unit:RegisterEvent("KeeperOrdanus_EntanglingRoots", 11000, 0)
	Unit:RegisterEvent("KeeperOrdanus_LightningBolt", 8000, 0)
end

function KeeperOrdanus_EntanglingRoots(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12747, 	pUnit:GetMainTank()) 
end

function KeeperOrdanus_LightningBolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9532, 	pUnit:GetMainTank()) 
end

function KeeperOrdanus_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function KeeperOrdanus_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(4273, 1, "KeeperOrdanus_OnCombat")
RegisterUnitEvent(4273, 2, "KeeperOrdanus_OnLeaveCombat")
RegisterUnitEvent(4273, 4, "KeeperOrdanus_OnDied")