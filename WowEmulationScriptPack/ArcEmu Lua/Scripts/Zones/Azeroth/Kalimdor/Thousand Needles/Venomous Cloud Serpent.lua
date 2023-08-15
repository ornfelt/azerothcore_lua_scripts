--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function VenomousCloudSerpent_OnCombat(Unit, Event)
	UnitRegisterEvent("VenomousCloudSerpent_DeadlyPoison", 10000, 0)
end

function VenomousCloudSerpent_DeadlyPoison(Unit, Event) 
	UnitFullCastSpellOnTarget(3583, 	UnitGetMainTank()) 
end

function VenomousCloudSerpent_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function VenomousCloudSerpent_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function VenomousCloudSerpent_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4118, 1, "VenomousCloudSerpent_OnCombat")
RegisterUnitEvent(4118, 2, "VenomousCloudSerpent_OnLeaveCombat")
RegisterUnitEvent(4118, 3, "VenomousCloudSerpent_OnKilledTarget")
RegisterUnitEvent(4118, 4, "VenomousCloudSerpent_OnDied")