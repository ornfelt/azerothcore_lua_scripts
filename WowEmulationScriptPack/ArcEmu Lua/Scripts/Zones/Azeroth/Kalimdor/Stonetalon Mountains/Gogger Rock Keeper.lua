--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GoggerRockKeeper_OnCombat(Unit, Event)
	UnitRegisterEvent("GoggerRockKeeper_EarthShock", 8000, 0)
end

function GoggerRockKeeper_EarthShock(Unit, Event) 
	UnitFullCastSpellOnTarget(13281, 	UnitGetMainTank()) 
end

function GoggerRockKeeper_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function GoggerRockKeeper_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function GoggerRockKeeper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11915, 1, "GoggerRockKeeper_OnCombat")
RegisterUnitEvent(11915, 2, "GoggerRockKeeper_OnLeaveCombat")
RegisterUnitEvent(11915, 3, "GoggerRockKeeper_OnKilledTarget")
RegisterUnitEvent(11915, 4, "GoggerRockKeeper_OnDied")