--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ScreechingRoguefeather_OnCombat(Unit, Event)
	UnitRegisterEvent("ScreechingRoguefeather_ExploitWeakness", 5000, 0)
end

function ScreechingRoguefeather_ExploitWeakness(Unit, Event) 
	UnitFullCastSpellOnTarget(6595, 	UnitGetMainTank()) 
end

function ScreechingRoguefeather_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function ScreechingRoguefeather_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function ScreechingRoguefeather_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4101, 1, "ScreechingRoguefeather_OnCombat")
RegisterUnitEvent(4101, 2, "ScreechingRoguefeather_OnLeaveCombat")
RegisterUnitEvent(4101, 3, "ScreechingRoguefeather_OnKilledTarget")
RegisterUnitEvent(4101, 4, "ScreechingRoguefeather_OnDied")