--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function PridewingWyvern_OnCombat(Unit, Event)
	UnitRegisterEvent("PridewingWyvern_CorrosivePoison", 10000, 0)
end

function PridewingWyvern_CorrosivePoison(Unit, Event) 
	UnitFullCastSpellOnTarget(3397, 	UnitGetMainTank()) 
end

function PridewingWyvern_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function PridewingWyvern_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function PridewingWyvern_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4012, 1, "PridewingWyvern_OnCombat")
RegisterUnitEvent(4012, 2, "PridewingWyvern_OnLeaveCombat")
RegisterUnitEvent(4012, 3, "PridewingWyvern_OnKilledTarget")
RegisterUnitEvent(4012, 4, "PridewingWyvern_OnDied")