--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AberrantOwlbeast_OnCombat(Unit, Event)
	Unit:RegisterEvent("AberrantOwlbeast_Moonfire", 6000, 0)
end

function AberrantOwlbeast_Moonfire(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(31270, 	pUnit:GetRandomPlayer(0)) 
end

function AberrantOwlbeast_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function AberrantOwlbeast_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17187, 1, "AberrantOwlbeast_OnCombat")
RegisterUnitEvent(17187, 2, "AberrantOwlbeast_OnLeaveCombat")
RegisterUnitEvent(17187, 4, "AberrantOwlbeast_OnDied")