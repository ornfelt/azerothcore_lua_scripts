--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CarnivoustheBreaker_OnCombat(Unit, Event)
	Unit:RegisterEvent("CarnivoustheBreaker_PierceArmor", 9000, 0)
	Unit:RegisterEvent("CarnivoustheBreaker_Thrash", 5000, 0)
end

function CarnivoustheBreaker_PierceArmor(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6016, 	pUnit:GetMainTank()) 
end

function CarnivoustheBreaker_Thrash(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3391, 	pUnit:GetMainTank()) 
end

function CarnivoustheBreaker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function CarnivoustheBreaker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2186, 1, "CarnivoustheBreaker_OnCombat")
RegisterUnitEvent(2186, 2, "CarnivoustheBreaker_OnLeaveCombat")
RegisterUnitEvent(2186, 4, "CarnivoustheBreaker_OnDied")