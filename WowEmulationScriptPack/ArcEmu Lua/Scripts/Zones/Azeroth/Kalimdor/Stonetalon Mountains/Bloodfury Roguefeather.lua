--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function BloodfuryRoguefeather_OnCombat(Unit, Event)
	UnitRegisterEvent("BloodfuryRoguefeather_Thrash", 5000, 0)
end

function BloodfuryRoguefeather_Thrash(Unit, Event) 
	UnitFullCastSpellOnTarget(3391, 	UnitGetMainTank()) 
end

function BloodfuryRoguefeather_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function BloodfuryRoguefeather_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function BloodfuryRoguefeather_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4023, 1, "BloodfuryRoguefeather_OnCombat")
RegisterUnitEvent(4023, 2, "BloodfuryRoguefeather_OnLeaveCombat")
RegisterUnitEvent(4023, 3, "BloodfuryRoguefeather_OnKilledTarget")
RegisterUnitEvent(4023, 4, "BloodfuryRoguefeather_OnDied")