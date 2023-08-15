--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TimberlingBarkRipper_OnCombat(Unit, Event)
	Unit:RegisterEvent("TimberlingBarkRipper_PierceArmor", 8000, 0)
end

function TimberlingBarkRipper_PierceArmor(Unit, Event) 
	Unit:FullCastSpellOnTarget(6016, 	Unit:GetMainTank()) 
end

function TimberlingBarkRipper_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TimberlingBarkRipper_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function TimberlingBarkRipper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2025, 1, "TimberlingBarkRipper_OnCombat")
RegisterUnitEvent(2025, 2, "TimberlingBarkRipper_OnLeaveCombat")
RegisterUnitEvent(2025, 3, "TimberlingBarkRipper_OnKilledTarget")
RegisterUnitEvent(2025, 4, "TimberlingBarkRipper_OnDied")