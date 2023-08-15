--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function HighperchWyvern_OnCombat(Unit, Event)
	UnitRegisterEvent("HighperchWyvern_Poison", 12000, 0)
end

function HighperchWyvern_Poison(Unit, Event) 
	UnitFullCastSpellOnTarget(744, 	UnitGetMainTank()) 
end

function HighperchWyvern_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function HighperchWyvern_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function HighperchWyvern_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4107, 1, "HighperchWyvern_OnCombat")
RegisterUnitEvent(4107, 2, "HighperchWyvern_OnLeaveCombat")
RegisterUnitEvent(4107, 3, "HighperchWyvern_OnKilledTarget")
RegisterUnitEvent(4107, 4, "HighperchWyvern_OnDied")