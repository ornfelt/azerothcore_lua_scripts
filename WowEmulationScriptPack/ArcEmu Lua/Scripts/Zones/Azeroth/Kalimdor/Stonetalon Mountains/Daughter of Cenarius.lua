--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function DaughterofCenarius_OnCombat(Unit, Event)
	UnitRegisterEvent("DaughterofCenarius_DispelMagic", 6000, 0)
	UnitRegisterEvent("DaughterofCenarius_Throw", 4000, 0)
end

function DaughterofCenarius_DispelMagic(Unit, Event) 
	UnitCastSpell(527) 
end

function DaughterofCenarius_Throw(Unit, Event) 
	UnitFullCastSpellOnTarget(10277, 	UnitGetMainTank()) 
end

function DaughterofCenarius_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function DaughterofCenarius_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function DaughterofCenarius_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4053, 1, "DaughterofCenarius_OnCombat")
RegisterUnitEvent(4053, 2, "DaughterofCenarius_OnLeaveCombat")
RegisterUnitEvent(4053, 3, "DaughterofCenarius_OnKilledTarget")
RegisterUnitEvent(4053, 4, "DaughterofCenarius_OnDied")