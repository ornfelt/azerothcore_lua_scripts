--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ElderDarkshoreThresher_OnCombat(Unit, Event)
	Unit:RegisterEvent("ElderDarkshoreThresher_PierceArmor", 9000, 0)
end

function ElderDarkshoreThresher_PierceArmor(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6016, 	pUnit:GetMainTank()) 
end

function ElderDarkshoreThresher_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ElderDarkshoreThresher_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2187, 1, "ElderDarkshoreThresher_OnCombat")
RegisterUnitEvent(2187, 2, "ElderDarkshoreThresher_OnLeaveCombat")
RegisterUnitEvent(2187, 4, "ElderDarkshoreThresher_OnDied")