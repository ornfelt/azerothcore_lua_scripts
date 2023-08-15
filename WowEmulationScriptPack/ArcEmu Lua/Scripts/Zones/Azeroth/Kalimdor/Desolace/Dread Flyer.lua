--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DreadFlyer_OnCombat(Unit, Event)
	Unit:RegisterEvent("DreadFlyer_Disarm", 10000, 0)
end

function DreadFlyer_Disarm(Unit, Event) 
	Unit:FullCastSpellOnTarget(6713, 	Unit:GetMainTank()) 
end

function DreadFlyer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DreadFlyer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(4693, 1, "DreadFlyer_OnCombat")
RegisterUnitEvent(4693, 2, "DreadFlyer_OnLeaveCombat")
RegisterUnitEvent(4693, 4, "DreadFlyer_OnDied")