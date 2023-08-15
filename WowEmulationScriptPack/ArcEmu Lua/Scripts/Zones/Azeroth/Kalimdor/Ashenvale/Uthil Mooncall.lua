--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function UthilMooncall_OnCombat(Unit, Event)
	Unit:RegisterEvent("UthilMooncall_BearForm", 1000, 1)
	Unit:RegisterEvent("UthilMooncall_Maul", 5000, 0)
end

function UthilMooncall_BearForm(pUnit, Event) 
	pUnit:CastSpell(7090) 
end

function UthilMooncall_Maul(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12161, 	pUnit:GetMainTank()) 
end

function UthilMooncall_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function UthilMooncall_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3941, 1, "UthilMooncall_OnCombat")
RegisterUnitEvent(3941, 2, "UthilMooncall_OnLeaveCombat")
RegisterUnitEvent(3941, 4, "UthilMooncall_OnDied")