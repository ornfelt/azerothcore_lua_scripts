--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function TimbermawShaman_OnCombat(Unit, Event)
	Unit:RegisterEvent("TimbermawShaman_LightningBolt", 8000, 0)
end

function TimbermawShaman_LightningBolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(20295, 	pUnit:GetMainTank()) 
end

function TimbermawShaman_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TimbermawShaman_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6188, 1, "TimbermawShaman_OnCombat")
RegisterUnitEvent(6188, 2, "TimbermawShaman_OnLeaveCombat")
RegisterUnitEvent(6188, 4, "TimbermawShaman_OnDied")