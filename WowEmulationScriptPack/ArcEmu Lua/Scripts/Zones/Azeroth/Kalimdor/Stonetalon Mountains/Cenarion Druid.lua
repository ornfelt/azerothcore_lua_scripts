--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CenarionDruid_OnCombat(Unit, Event)
	UnitRegisterEvent("CenarionDruid_Wrath", 5000, 2)
	UnitRegisterEvent("CenarionDruid_CatForm", 12000, 1)
	UnitRegisterEvent("CenarionDruid_TigersFury", 14000, 1)
end

function CenarionDruid_Wrath(Unit, Event) 
	UnitFullCastSpellOnTarget(9739, 	UnitGetMainTank()) 
end

function CenarionDruid_CatForm(Unit, Event) 
	UnitCastSpell(5759) 
end

function CenarionDruid_TigersFury(Unit, Event) 
	UnitCastSpell(5217) 
end

function CenarionDruid_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function CenarionDruid_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function CenarionDruid_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4052, 1, "CenarionDruid_OnCombat")
RegisterUnitEvent(4052, 2, "CenarionDruid_OnLeaveCombat")
RegisterUnitEvent(4052, 3, "CenarionDruid_OnKilledTarget")
RegisterUnitEvent(4052, 4, "CenarionDruid_OnDied")