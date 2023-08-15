--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function DeepmossHatchling_OnCombat(Unit, Event)
	UnitRegisterEvent("DaughterofCenarius_SummonDeepmossMatriarch", 4000, 1)
end

function DeepmossCreeper_Poison(Unit, Event) 
	UnitFullCastSpellOnTarget(744, 	UnitGetMainTank()) 
end

function DaughterofCenarius_SummonDeepmossMatriarch(Unit, Event) 
	UnitCastSpell(6536) 
end

function DeepmossHatchling_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function DeepmossHatchling_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function DeepmossHatchling_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4263, 1, "DeepmossHatchling_OnCombat")
RegisterUnitEvent(4263, 2, "DeepmossHatchling_OnLeaveCombat")
RegisterUnitEvent(4263, 3, "DeepmossHatchling_OnKilledTarget")
RegisterUnitEvent(4263, 4, "DeepmossHatchling_OnDied")