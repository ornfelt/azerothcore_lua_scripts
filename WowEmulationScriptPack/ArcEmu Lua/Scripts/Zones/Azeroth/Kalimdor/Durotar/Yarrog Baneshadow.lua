--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function YarrogBaneshadow_OnCombat(Unit, Event)
	Unit:RegisterEvent("YarrogBaneshadow_Immolate", 6000, 0)
	Unit:RegisterEvent("YarrogBaneshadow_Corruption", 8000, 0)
end

function YarrogBaneshadow_Immolate(Unit, Event) 
	Unit:FullCastSpellOnTarget(348, 	Unit:GetMainTank()) 
end

function YarrogBaneshadow_Corruption(Unit, Event) 
	Unit:FullCastSpellOnTarget(172, 	Unit:GetMainTank()) 
end

function YarrogBaneshadow_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function YarrogBaneshadow_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function YarrogBaneshadow_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3183, 1, "YarrogBaneshadow_OnCombat")
RegisterUnitEvent(3183, 2, "YarrogBaneshadow_OnLeaveCombat")
RegisterUnitEvent(3183, 3, "YarrogBaneshadow_OnKilledTarget")
RegisterUnitEvent(3183, 4, "YarrogBaneshadow_OnDied")