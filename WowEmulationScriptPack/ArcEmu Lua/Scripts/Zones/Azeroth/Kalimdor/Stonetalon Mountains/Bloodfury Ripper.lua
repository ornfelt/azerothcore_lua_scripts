--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BloodfuryRipper_OnCombat(Unit, Event)
	UnitRegisterEvent("BloodfuryRipper_Enrage", 15000, 1)
	UnitRegisterEvent("BloodfuryRipper_Rend", 10000, 0)
end

function BloodfuryRipper_Enrage(Unit, Event) 
	UnitCastSpell(8599) 
end

function BloodfuryRipper_Rend(Unit, Event) 
	UnitFullCastSpellOnTarget(13443, 	UnitGetMainTank()) 
end

function BloodfuryRipper_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function BloodfuryRipper_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function BloodfuryRipper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(12579, 1, "BloodfuryRipper_OnCombat")
RegisterUnitEvent(12579, 2, "BloodfuryRipper_OnLeaveCombat")
RegisterUnitEvent(12579, 3, "BloodfuryRipper_OnKilledTarget")
RegisterUnitEvent(12579, 4, "BloodfuryRipper_OnDied")