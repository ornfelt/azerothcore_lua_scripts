--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function VentureCoBuilder_OnCombat(Unit, Event)
	UnitRegisterEvent("VentureCoBuilder_Shoot", 6000, 0)
end

function VentureCoBuilder_Shoot(Unit, Event) 
	UnitFullCastSpellOnTarget(6660, 	UnitGetMainTank()) 
end

function VentureCoBuilder_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function VentureCoBuilder_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function VentureCoBuilder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4070, 1, "VentureCoBuilder_OnCombat")
RegisterUnitEvent(4070, 2, "VentureCoBuilder_OnLeaveCombat")
RegisterUnitEvent(4070, 3, "VentureCoBuilder_OnKilledTarget")
RegisterUnitEvent(4070, 4, "VentureCoBuilder_OnDied")