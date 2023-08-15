--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BloodfurySlayer_OnCombat(Unit, Event)
	UnitRegisterEvent("BloodfuryRoguefeather_CurseofRecklessness", 5000, 2)
end

function BloodfuryRoguefeather_CurseofRecklessness(Unit, Event) 
	UnitFullCastSpellOnTarget(16231, 	UnitGetMainTank()) 
end

function BloodfurySlayer_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function BloodfurySlayer_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function BloodfurySlayer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4024, 1, "BloodfurySlayer_OnCombat")
RegisterUnitEvent(4024, 2, "BloodfurySlayer_OnLeaveCombat")
RegisterUnitEvent(4024, 3, "BloodfurySlayer_OnKilledTarget")
RegisterUnitEvent(4024, 4, "BloodfurySlayer_OnDied")