--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function RoamingFelguard_OnCombat(Unit, Event)
	Unit:RegisterEvent("RoamingFelguard_Knockdown", 8000, 0)
end

function RoamingFelguard_Knockdown(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(11428, 	pUnit:GetMainTank()) 
end

function RoamingFelguard_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RoamingFelguard_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6115, 1, "RoamingFelguard_OnCombat")
RegisterUnitEvent(6115, 2, "RoamingFelguard_OnLeaveCombat")
RegisterUnitEvent(6115, 4, "RoamingFelguard_OnDied")