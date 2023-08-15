--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CenarionBotanist_OnCombat(Unit, Event)
	UnitRegisterEvent("CenarionBotanist_Rejuvenation", 10000, 0)
	UnitRegisterEvent("CenarionBotanist_Wrath", 7000, 0)
end

function CenarionBotanist_Rejuvenation(Unit, Event) 
	UnitCastSpell(1430) 
end

function CenarionBotanist_Wrath(Unit, Event) 
	UnitFullCastSpellOnTarget(9739, 	UnitGetMainTank()) 
end

function CenarionBotanist_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function CenarionBotanist_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function CenarionBotanist_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4051, 1, "CenarionBotanist_OnCombat")
RegisterUnitEvent(4051, 2, "CenarionBotanist_OnLeaveCombat")
RegisterUnitEvent(4051, 3, "CenarionBotanist_OnKilledTarget")
RegisterUnitEvent(4051, 4, "CenarionBotanist_OnDied")