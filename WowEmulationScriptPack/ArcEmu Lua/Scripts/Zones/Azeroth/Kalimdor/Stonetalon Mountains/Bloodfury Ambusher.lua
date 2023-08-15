--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function BloodfuryAmbusher_OnCombat(Unit, Event)
	UnitRegisterEvent("BloodfuryAmbusher_Shock", 8000, 1)
end

function BloodfuryAmbusher_Shock(Unit, Event) 
	UnitFullCastSpellOnTarget(2608, 	UnitGetMainTank()) 
end

function BloodfuryAmbusher_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function BloodfuryAmbusher_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function BloodfuryAmbusher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4025, 1, "BloodfuryAmbusher_OnCombat")
RegisterUnitEvent(4025, 2, "BloodfuryAmbusher_OnLeaveCombat")
RegisterUnitEvent(4025, 3, "BloodfuryAmbusher_OnKilledTarget")
RegisterUnitEvent(4025, 4, "BloodfuryAmbusher_OnDied")