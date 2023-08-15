--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MoongrazeBuck_OnCombat(Unit, Event)
	Unit:RegisterEvent("MoongrazeBuck_Knockdown", 7000, 0)
end

function MoongrazeBuck_Knockdown(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(31274, 	pUnit:GetMainTank()) 
end

function MoongrazeBuck_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MoongrazeBuck_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17201, 1, "MoongrazeBuck_OnCombat")
RegisterUnitEvent(17201, 2, "MoongrazeBuck_OnLeaveCombat")
RegisterUnitEvent(17201, 4, "MoongrazeBuck_OnDied")