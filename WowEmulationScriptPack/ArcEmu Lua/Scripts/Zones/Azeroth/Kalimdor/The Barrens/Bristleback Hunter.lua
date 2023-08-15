--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BristlebackHunter_OnCombat(Unit, Event)
	Unit:RegisterEvent("BristlebackHunter_Shoot", 5000, 0)
	Unit:RegisterEvent("BristlebackHunter_PoisonedShot", 1000, 1)
end

function BristlebackHunter_Shoot(Unit, Event) 
	Unit:FullCastSpellOnTarget(6660, 	Unit:GetMainTank()) 
end

function BristlebackHunter_PoisonedShot(Unit, Event) 
	Unit:FullCastSpellOnTarget(8806, 	Unit:GetMainTank()) 
end

function BristlebackHunter_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BristlebackHunter_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function BristlebackHunter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3258, 1, "BristlebackHunter_OnCombat")
RegisterUnitEvent(3258, 2, "BristlebackHunter_OnLeaveCombat")
RegisterUnitEvent(3258, 3, "BristlebackHunter_OnKilledTarget")
RegisterUnitEvent(3258, 4, "BristlebackHunter_OnDied")