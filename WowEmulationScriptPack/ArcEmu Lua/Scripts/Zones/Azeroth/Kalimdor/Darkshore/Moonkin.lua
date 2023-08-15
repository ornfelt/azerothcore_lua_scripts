--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Moonkin_OnCombat(Unit, Event)
	Unit:RegisterEvent("Moonkin_Thrash", 6000, 0)
end

function Moonkin_Thrash(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3391, 	pUnit:GetMainTank()) 
end

function Moonkin_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Moonkin_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(10158, 1, "Moonkin_OnCombat")
RegisterUnitEvent(10158, 2, "Moonkin_OnLeaveCombat")
RegisterUnitEvent(10158, 4, "Moonkin_OnDied")