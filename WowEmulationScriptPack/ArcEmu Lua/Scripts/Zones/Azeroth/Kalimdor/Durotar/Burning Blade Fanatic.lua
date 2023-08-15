--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BurningBladeFanatic_OnCombat(Unit, Event)
	UnitRegisterEvent("BurningBladeFanatic_FanaticBlade", 8000, 0)
end

function BurningBladeFanatic_FanaticBlade(Unit, Event) 
	UnitCastSpell(5262) 
end

function BurningBladeFanatic_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function BurningBladeFanatic_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function BurningBladeFanatic_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3197, 1, "BurningBladeFanatic_OnCombat")
RegisterUnitEvent(3197, 2, "BurningBladeFanatic_OnLeaveCombat")
RegisterUnitEvent(3197, 3, "BurningBladeFanatic_OnKilledTarget")
RegisterUnitEvent(3197, 4, "BurningBladeFanatic_OnDied")