--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function Gibblesnik_OnCombat(Unit, Event)
	UnitRegisterEvent("Gibblesnik_SunderArmor", 6000, 0)
end

function Gibblesnik_SunderArmor(Unit, Event) 
	UnitFullCastSpellOnTarget(11971, 	UnitGetMainTank()) 
end

function Gibblesnik_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function Gibblesnik_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function Gibblesnik_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4093, 1, "GalakWrangler_OnCombat")
RegisterUnitEvent(4093, 2, "GalakWrangler_OnLeaveCombat")
RegisterUnitEvent(4093, 3, "GalakWrangler_OnKilledTarget")
RegisterUnitEvent(4093, 4, "GalakWrangler_OnDied")