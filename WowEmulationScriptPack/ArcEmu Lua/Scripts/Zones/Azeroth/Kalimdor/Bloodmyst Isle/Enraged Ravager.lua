--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function EnragedRavager_OnCombat(Unit, Event)
	Unit:RegisterEvent("EnragedRavager_Enrage", 10000, 1)
	Unit:RegisterEvent("EnragedRavager_Ravage", 8000, 0)
end

function EnragedRavager_Enrage(pUnit, Event) 
	pUnit:CastSpell(15716) 
end

function EnragedRavager_Ravage(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3242, 	pUnit:GetMainTank()) 
end

function EnragedRavager_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function EnragedRavager_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17527, 1, "EnragedRavager_OnCombat")
RegisterUnitEvent(17527, 2, "EnragedRavager_OnLeaveCombat")
RegisterUnitEvent(17527, 4, "EnragedRavager_OnDied")