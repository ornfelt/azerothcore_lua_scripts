--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function DustwindStormWitch_OnCombat(Unit, Event)
	UnitRegisterEvent("DustwindStormWitch_LightningBolt", 8000, 0)
end

function DustwindStormWitch_LightningBolt(Unit, Event) 
	UnitFullCastSpellOnTarget(9532, 	UnitGetMainTank()) 
end

function DustwindStormWitch_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function DustwindStormWitch_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function DustwindStormWitch_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3118, 1, "DustwindStormWitch_OnCombat")
RegisterUnitEvent(3118, 2, "DustwindStormWitch_OnLeaveCombat")
RegisterUnitEvent(3118, 3, "DustwindStormWitch_OnKilledTarget")
RegisterUnitEvent(3118, 4, "DustwindStormWitch_OnDied")