--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MammothShark_OnCombat(Unit, Event)
	Unit:RegisterEvent("MammothShark_Thrash", 5000, 0)
end

function MammothShark_Thrash(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3391, 	pUnit:GetMainTank()) 
end

function MammothShark_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MammothShark_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(12125, 1, "MammothShark_OnCombat")
RegisterUnitEvent(12125, 2, "MammothShark_OnLeaveCombat")
RegisterUnitEvent(12125, 4, "MammothShark_OnDied")