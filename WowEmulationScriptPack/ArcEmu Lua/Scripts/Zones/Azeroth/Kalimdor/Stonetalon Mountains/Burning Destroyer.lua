--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function BurningDestroyer_OnCombat(Unit, Event)
	UnitRegisterEvent("BurningDestroyer_AreaBurn", 3000, 2)
	UnitRegisterEvent("BurningDestroyer_Fireball", 8000, 0)
end

function BurningDestroyer_AreaBurn(Unit, Event) 
	UnitCastSpell(8000) 
end

function BurningDestroyer_Fireball(Unit, Event) 
	UnitFullCastSpellOnTarget(9053, 	UnitGetMainTank()) 
end

function BurningDestroyer_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function BurningDestroyer_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function BurningDestroyer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4038, 1, "BurningDestroyer_OnCombat")
RegisterUnitEvent(4038, 2, "BurningDestroyer_OnLeaveCombat")
RegisterUnitEvent(4038, 3, "BurningDestroyer_OnKilledTarget")
RegisterUnitEvent(4038, 4, "BurningDestroyer_OnDied")