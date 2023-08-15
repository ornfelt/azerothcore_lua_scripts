--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DiathorustheSeeker_OnCombat(Unit, Event)
	Unit:RegisterEvent("DiathorustheSeeker_DrainLife", 8000, 0)
end

function DiathorustheSeeker_DrainLife(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(18557, 	pUnit:GetMainTank()) 
end

function DiathorustheSeeker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DiathorustheSeeker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6072, 1, "DiathorustheSeeker_OnCombat")
RegisterUnitEvent(6072, 2, "DiathorustheSeeker_OnLeaveCombat")
RegisterUnitEvent(6072, 4, "DiathorustheSeeker_OnDied")