--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function RexAshil_OnCombat(Unit, Event)
	Unit:RegisterEvent("RexAshil_PierceArmor", 8000, 0)
end

function RexAshil_PierceArmor(Unit, Event) 
	Unit:FullCastSpellOnTarget(12097, 	Unit:GetMainTank()) 
end

function RexAshil_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RexAshil_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function RexAshil_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(14475, 1, "RexAshil_OnCombat")
RegisterUnitEvent(14475, 2, "RexAshil_OnLeaveCombat")
RegisterUnitEvent(14475, 3, "RexAshil_OnKilledTarget")
RegisterUnitEvent(14475, 4, "RexAshil_OnDied")