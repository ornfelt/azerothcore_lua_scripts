--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function PesterhideSnarler_OnCombat(Unit, Event)
	UnitRegisterEvent("PesterhideSnarler_IntimidatingGrowl", 8000, 0)
end

function PesterhideSnarler_IntimidatingGrowl(Unit, Event) 
	UnitFullCastSpellOnTarget(6576, 	UnitGetMainTank()) 
end

function PesterhideSnarler_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function PesterhideSnarler_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function PesterhideSnarler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4249, 1, "PesterhideSnarler_OnCombat")
RegisterUnitEvent(4249, 2, "PesterhideSnarler_OnLeaveCombat")
RegisterUnitEvent(4249, 3, "PesterhideSnarler_OnKilledTarget")
RegisterUnitEvent(4249, 4, "PesterhideSnarler_OnDied")