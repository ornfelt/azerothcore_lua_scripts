--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function VorshatheLasher_OnCombat(Unit, Event)
	Unit:RegisterEvent("VorshatheLasher_Lash", 6000, 0)
	Unit:RegisterEvent("VorshatheLasher_Thrash", 5000, 0)
end

function VorshatheLasher_Lash(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6607, 	pUnit:GetMainTank()) 
end

function VorshatheLasher_Thrash(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3391, 	pUnit:GetMainTank()) 
end

function VorshatheLasher_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function VorshatheLasher_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(12940, 1, "VorshatheLasher_OnCombat")
RegisterUnitEvent(12940, 2, "VorshatheLasher_OnLeaveCombat")
RegisterUnitEvent(12940, 4, "VorshatheLasher_OnDied")