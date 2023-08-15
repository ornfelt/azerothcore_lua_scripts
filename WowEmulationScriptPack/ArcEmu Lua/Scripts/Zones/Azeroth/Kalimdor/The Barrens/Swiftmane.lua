--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Swiftmane_OnCombat(Unit, Event)
	Unit:RegisterEvent("Swiftmane_PierceArmor", 10000, 0)
end

function Swiftmane_PierceArmor(Unit, Event) 
	Unit:FullCastSpellOnTarget(6016, 	Unit:GetMainTank()) 
end

function Swiftmane_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Swiftmane_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Swiftmane_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5831, 1, "Swiftmane_OnCombat")
RegisterUnitEvent(5831, 2, "Swiftmane_OnLeaveCombat")
RegisterUnitEvent(5831, 3, "Swiftmane_OnKilledTarget")
RegisterUnitEvent(5831, 4, "Swiftmane_OnDied")