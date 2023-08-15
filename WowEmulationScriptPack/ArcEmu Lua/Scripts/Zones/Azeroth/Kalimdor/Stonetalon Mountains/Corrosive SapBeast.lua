--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CorrosiveSapBeast_OnCombat(Unit, Event)
	UnitRegisterEvent("CorrosiveSapBeast_CorrosivePoison", 10000, 0)
end

function CorrosiveSapBeast_CorrosivePoison(Unit, Event) 
	UnitFullCastSpellOnTarget(3397, 	UnitGetMainTank()) 
end

function CorrosiveSapBeast_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function CorrosiveSapBeast_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function CorrosiveSapBeast_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4021, 1, "CorrosiveSapBeast_OnCombat")
RegisterUnitEvent(4021, 2, "CorrosiveSapBeast_OnLeaveCombat")
RegisterUnitEvent(4021, 3, "CorrosiveSapBeast_OnKilledTarget")
RegisterUnitEvent(4021, 4, "CorrosiveSapBeast_OnDied")