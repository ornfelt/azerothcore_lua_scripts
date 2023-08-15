--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CloudSerpent_OnCombat(Unit, Event)
	UnitRegisterEvent("CloudSerpent_LightningBolt", 8000, 0)
end

function CloudSerpent_LightningBolt(Unit, Event) 
	UnitFullCastSpellOnTarget(8246, 	UnitGetMainTank()) 
end

function CloudSerpent_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function CloudSerpent_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function CloudSerpent_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4117, 1, "CloudSerpent_OnCombat")
RegisterUnitEvent(4117, 2, "CloudSerpent_OnLeaveCombat")
RegisterUnitEvent(4117, 3, "CloudSerpent_OnKilledTarget")
RegisterUnitEvent(4117, 4, "CloudSerpent_OnDied")