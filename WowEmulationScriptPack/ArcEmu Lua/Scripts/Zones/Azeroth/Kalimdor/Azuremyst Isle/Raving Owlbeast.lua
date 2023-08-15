--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function RavingOwlbeast_OnCombat(Unit, Event)
	Unit:RegisterEvent("RavingOwlbeast_Enrage", 10000, 0)
end

function RavingOwlbeast_Enrage(pUnit, Event) 
	pUnit:CastSpell(8599) 
end

function RavingOwlbeast_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RavingOwlbeast_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17188, 1, "RavingOwlbeast_OnCombat")
RegisterUnitEvent(17188, 2, "RavingOwlbeast_OnLeaveCombat")
RegisterUnitEvent(17188, 4, "RavingOwlbeast_OnDied")