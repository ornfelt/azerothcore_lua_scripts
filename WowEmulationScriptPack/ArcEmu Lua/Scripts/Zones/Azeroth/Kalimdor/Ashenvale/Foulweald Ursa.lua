--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function FoulwealdUrsa_OnCombat(Unit, Event)
	Unit:RegisterEvent("FoulwealdUrsa_Hamstring", 10000, 0)
end

function FoulwealdUrsa_Hamstring(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9080, 	pUnit:GetMainTank()) 
end

function FoulwealdUrsa_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function FoulwealdUrsa_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3749, 1, "FoulwealdUrsa_OnCombat")
RegisterUnitEvent(3749, 2, "FoulwealdUrsa_OnLeaveCombat")
RegisterUnitEvent(3749, 4, "FoulwealdUrsa_OnDied")