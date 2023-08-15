--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function FelweaverScornn_OnCombat(Unit, Event)
	Unit:RegisterEvent("FelweaverScornn_ShadowBolt", 8000, 0)
end

function FelweaverScornn_ShadowBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(9613, 	Unit:GetMainTank()) 
end

function FelweaverScornn_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function FelweaverScornn_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function FelweaverScornn_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5822, 1, "FelweaverScornn_OnCombat")
RegisterUnitEvent(5822, 2, "FelweaverScornn_OnLeaveCombat")
RegisterUnitEvent(5822, 3, "FelweaverScornn_OnKilledTarget")
RegisterUnitEvent(5822, 4, "FelweaverScornn_OnDied")