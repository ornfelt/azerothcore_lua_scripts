--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function FuriousStoneSpirit_OnCombat(Unit, Event)
	UnitRegisterEvent("FuriousStoneSpirit_Knockdown", 8000, 0)
end

function FuriousStoneSpirit_Knockdown(Unit, Event) 
	UnitFullCastSpellOnTarget(5164, 	UnitGetMainTank()) 
end

function FuriousStoneSpirit_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function FuriousStoneSpirit_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function FuriousStoneSpirit_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4035, 1, "FuriousStoneSpirit_OnCombat")
RegisterUnitEvent(4035, 2, "FuriousStoneSpirit_OnLeaveCombat")
RegisterUnitEvent(4035, 3, "FuriousStoneSpirit_OnKilledTarget")
RegisterUnitEvent(4035, 4, "FuriousStoneSpirit_OnDied")