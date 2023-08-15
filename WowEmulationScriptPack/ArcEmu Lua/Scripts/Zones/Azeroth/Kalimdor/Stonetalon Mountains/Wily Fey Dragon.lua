--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WilyFeyDragon_OnCombat(Unit, Event)
	UnitRegisterEvent("WilyFeyDragon_ManaBurn", 6000, 0)
end

function WilyFeyDragon_ManaBurn(Unit, Event) 
	UnitFullCastSpellOnTarget(17630, 	UnitGetRandomPlayer(4)) 
end

function WilyFeyDragon_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function WilyFeyDragon_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function WilyFeyDragon_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4017, 1, "WilyFeyDragon_OnCombat")
RegisterUnitEvent(4017, 2, "WilyFeyDragon_OnLeaveCombat")
RegisterUnitEvent(4017, 3, "WilyFeyDragon_OnKilledTarget")
RegisterUnitEvent(4017, 4, "WilyFeyDragon_OnDied")