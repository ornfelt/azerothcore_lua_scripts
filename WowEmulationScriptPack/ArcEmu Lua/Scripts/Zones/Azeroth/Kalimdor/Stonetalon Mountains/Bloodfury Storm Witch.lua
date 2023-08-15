--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BloodfuryStormWitch_OnCombat(Unit, Event)
	UnitRegisterEvent("BloodfuryStormWitch_LightningBolt", 8000, 0)
	UnitRegisterEvent("BloodfuryStormWitch_LightningCloud", 4000, 1)
end

function BloodfuryStormWitch_LightningBolt(Unit, Event) 
	UnitFullCastSpellOnTarget(9532, 	UnitGetMainTank()) 
end

function BloodfuryStormWitch_LightningCloud(Unit, Event) 
	UnitFullCastSpellOnTarget(6535, 	UnitGetMainTank()) 
end

function BloodfuryStormWitch_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function BloodfuryStormWitch_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function BloodfuryStormWitch_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4027, 1, "BloodfuryStormWitch_OnCombat")
RegisterUnitEvent(4027, 2, "BloodfuryStormWitch_OnLeaveCombat")
RegisterUnitEvent(4027, 3, "BloodfuryStormWitch_OnKilledTarget")
RegisterUnitEvent(4027, 4, "BloodfuryStormWitch_OnDied")