--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DurielMoonfire_OnCombat(Unit, Event)
	Unit:RegisterEvent("DurielMoonfire_Knockdown", 8000, 0)
	Unit:RegisterEvent("DurielMoonfire_PierceArmor", 6000, 0)
end

function DurielMoonfire_Knockdown(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(11428, 	pUnit:GetMainTank()) 
end

function DurielMoonfire_PierceArmor(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12097, 	pUnit:GetMainTank()) 
end

function DurielMoonfire_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DurielMoonfire_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(12860, 1, "DurielMoonfire_OnCombat")
RegisterUnitEvent(12860, 2, "DurielMoonfire_OnLeaveCombat")
RegisterUnitEvent(12860, 4, "DurielMoonfire_OnDied")