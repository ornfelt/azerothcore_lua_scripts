--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MonnostheElder_OnCombat(Unit, Event)
	Unit:RegisterEvent("MonnostheElder_KnockAway", 8000, 0)
	Unit:RegisterEvent("MonnostheElder_Trample", 5000, 0)
end

function MonnostheElder_KnockAway(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(10101, 	pUnit:GetMainTank()) 
end

function MonnostheElder_Trample(pUnit, Event) 
	pUnit:CastSpell(5568) 
end

function MonnostheElder_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MonnostheElder_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6646, 1, "MonnostheElder_OnCombat")
RegisterUnitEvent(6646, 2, "MonnostheElder_OnLeaveCombat")
RegisterUnitEvent(6646, 4, "MonnostheElder_OnDied")