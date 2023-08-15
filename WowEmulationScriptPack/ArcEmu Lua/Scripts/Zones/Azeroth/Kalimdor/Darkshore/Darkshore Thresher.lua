--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function DarkshoreThresher_OnCombat(Unit, Event)
	Unit:RegisterEvent("DarkshoreThresher_PierceArmor", 9000, 0)
end

function DarkshoreThresher_PierceArmor(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6016, 	pUnit:GetMainTank()) 
end

function DarkshoreThresher_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DarkshoreThresher_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2185, 1, "DarkshoreThresher_OnCombat")
RegisterUnitEvent(2185, 2, "DarkshoreThresher_OnLeaveCombat")
RegisterUnitEvent(2185, 4, "DarkshoreThresher_OnDied")