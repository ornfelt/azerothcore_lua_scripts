--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Heartrazor_OnCombat(Unit, Event)
	UnitRegisterEvent("Heartrazor_LethalToxin", 12000, 0)
end

function Heartrazor_LethalToxin(Unit, Event) 
	UnitFullCastSpellOnTarget(8256, 	UnitGetMainTank()) 
end

function Heartrazor_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function Heartrazor_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function Heartrazor_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5934, 1, "Heartrazor_OnCombat")
RegisterUnitEvent(5934, 2, "Heartrazor_OnLeaveCombat")
RegisterUnitEvent(5934, 3, "Heartrazor_OnKilledTarget")
RegisterUnitEvent(5934, 4, "Heartrazor_OnDied")