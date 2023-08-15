--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MistwingRogue_OnCombat(Unit, Event)
	Unit:RegisterEvent("MistwingRogue_LightningBolt", 8000, 0)
end

function MistwingRogue_LightningBolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9532, 	pUnit:GetMainTank()) 
end

function MistwingRogue_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MistwingRogue_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(8763, 1, "MistwingRogue_OnCombat")
RegisterUnitEvent(8763, 2, "MistwingRogue_OnLeaveCombat")
RegisterUnitEvent(8763, 4, "MistwingRogue_OnDied")