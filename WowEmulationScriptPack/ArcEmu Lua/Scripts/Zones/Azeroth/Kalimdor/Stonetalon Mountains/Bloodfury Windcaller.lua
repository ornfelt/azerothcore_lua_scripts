--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BloodfuryWindcaller_OnCombat(Unit, Event)
	UnitRegisterEvent("BloodfuryWindcaller_EnvelopingWinds", 15000, 0)
end

function BloodfuryWindcaller_EnvelopingWinds(Unit, Event) 
	UnitFullCastSpellOnTarget(6728, 	UnitGetMainTank()) 
end

function BloodfuryWindcaller_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function BloodfuryWindcaller_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function BloodfuryWindcaller_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4026, 1, "BloodfuryWindcaller_OnCombat")
RegisterUnitEvent(4026, 2, "BloodfuryWindcaller_OnLeaveCombat")
RegisterUnitEvent(4026, 3, "BloodfuryWindcaller_OnKilledTarget")
RegisterUnitEvent(4026, 4, "BloodfuryWindcaller_OnDied")