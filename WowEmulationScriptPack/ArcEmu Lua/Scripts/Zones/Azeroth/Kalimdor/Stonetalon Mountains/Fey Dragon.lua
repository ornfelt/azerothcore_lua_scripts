--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function FeyDragon_OnCombat(Unit, Event)
	UnitRegisterEvent("FeyDragon_NullifyMana", 6000, 0)
end

function FeyDragon_NullifyMana(Unit, Event) 
	UnitFullCastSpellOnTarget(7994, 	UnitGetRandomPlayer(4)) 
end

function FeyDragon_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function FeyDragon_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function FeyDragon_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4016, 1, "FeyDragon_OnCombat")
RegisterUnitEvent(4016, 2, "FeyDragon_OnLeaveCombat")
RegisterUnitEvent(4016, 3, "FeyDragon_OnKilledTarget")
RegisterUnitEvent(4016, 4, "FeyDragon_OnDied")