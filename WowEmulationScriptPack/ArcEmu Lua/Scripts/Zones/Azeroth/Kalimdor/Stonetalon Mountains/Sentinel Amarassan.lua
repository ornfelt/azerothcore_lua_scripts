--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SentinelAmarassan_OnCombat(Unit, Event)
	UnitRegisterEvent("SentinelAmarassan_Wrath", 5000, 2)
	UnitRegisterEvent("SentinelAmarassan_CatForm", 12000, 1)
	UnitRegisterEvent("SentinelAmarassan_TigersFury", 14000, 1)
end

function SentinelAmarassan_Wrath(Unit, Event) 
	UnitFullCastSpellOnTarget(9739, 	UnitGetMainTank()) 
end

function SentinelAmarassan_CatForm(Unit, Event) 
	UnitCastSpell(5759) 
end

function SentinelAmarassan_TigersFury(Unit, Event) 
	UnitCastSpell(5217) 
end

function SentinelAmarassan_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function SentinelAmarassan_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function SentinelAmarassan_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5916, 1, "SentinelAmarassan_OnCombat")
RegisterUnitEvent(5916, 2, "SentinelAmarassan_OnLeaveCombat")
RegisterUnitEvent(5916, 3, "SentinelAmarassan_OnKilledTarget")
RegisterUnitEvent(5916, 4, "SentinelAmarassan_OnDied")