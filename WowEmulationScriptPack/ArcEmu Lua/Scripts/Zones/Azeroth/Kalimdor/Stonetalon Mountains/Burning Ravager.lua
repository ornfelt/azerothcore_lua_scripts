--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BurningRavager_OnCombat(Unit, Event)
	UnitRegisterEvent("BurningRavager_FireShieldII", 4000, 2)
end

function BurningRavager_FireShieldII(Unit, Event) 
	UnitCastSpell(184) 
end

function BurningDestroyer_Fireball(Unit, Event) 
	UnitFullCastSpellOnTarget(9053, 	UnitGetMainTank()) 
end

function BurningRavager_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function BurningRavager_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function BurningRavager_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4037, 1, "BurningRavager_OnCombat")
RegisterUnitEvent(4037, 2, "BurningRavager_OnLeaveCombat")
RegisterUnitEvent(4037, 3, "BurningRavager_OnKilledTarget")
RegisterUnitEvent(4037, 4, "BurningRavager_OnDied")