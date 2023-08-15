--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ThunderingInvader_OnCombat(Unit, Event)
	Unit:RegisterEvent("ThunderingInvader_EarthShock", 6000, 0)
	Unit:RegisterEvent("ThunderingInvader_Knockdown", 8000, 0)
end

function ThunderingInvader_EarthShock(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(23114, 	pUnit:GetMainTank()) 
end

function ThunderingInvader_Knockdown(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(11428, 	pUnit:GetMainTank()) 
end

function ThunderingInvader_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ThunderingInvader_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(14462, 1, "ThunderingInvader_OnCombat")
RegisterUnitEvent(14462, 2, "ThunderingInvader_OnLeaveCombat")
RegisterUnitEvent(14462, 4, "ThunderingInvader_OnDied")