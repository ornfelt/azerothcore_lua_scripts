--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ElderCloudSerpent_OnCombat(Unit, Event)
	UnitRegisterEvent("ElderCloudSerpent_LightningBolt", 8000, 0)
end

function ElderCloudSerpent_LightningBolt(Unit, Event) 
	UnitFullCastSpellOnTarget(8246, 	UnitGetMainTank()) 
end

function ElderCloudSerpent_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function ElderCloudSerpent_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function ElderCloudSerpent_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4119, 1, "ElderCloudSerpent_OnCombat")
RegisterUnitEvent(4119, 2, "ElderCloudSerpent_OnLeaveCombat")
RegisterUnitEvent(4119, 3, "ElderCloudSerpent_OnKilledTarget")
RegisterUnitEvent(4119, 4, "ElderCloudSerpent_OnDied")