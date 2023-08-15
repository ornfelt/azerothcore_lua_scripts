--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HighborneApparition_OnCombat(Unit, Event)
	Unit:RegisterEvent("HighborneApparition_Fear", 12000, 0)
end

function HighborneApparition_Fear(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12542, 	pUnit:GetMainTank()) 
end

function HighborneApparition_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HighborneApparition_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6116, 1, "HighborneApparition_OnCombat")
RegisterUnitEvent(6116, 2, "HighborneApparition_OnLeaveCombat")
RegisterUnitEvent(6116, 4, "HighborneApparition_OnDied")