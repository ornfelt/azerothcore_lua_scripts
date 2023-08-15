--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CenarionCaretaker_OnCombat(Unit, Event)
	UnitRegisterEvent("CenarionCaretaker_Maul", 5000, 0)
	UnitRegisterEvent("CenarionCaretaker_BearForm", 2000, 1)
	UnitRegisterEvent("CenarionCaretaker_Thorns", 1000, 1)
end

function CenarionCaretaker_BearForm(Unit, Event) 
	UnitCastSpell(7090) 
end

function CenarionCaretaker_Maul(Unit, Event) 
	UnitFullCastSpellOnTarget(12616, 	UnitGetMainTank()) 
end

function CenarionCaretaker_Thorns(Unit, Event) 
	UnitCastSpell(782) 
end

function CenarionCaretaker_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function CenarionCaretaker_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function CenarionCaretaker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4050, 1, "CenarionCaretaker_OnCombat")
RegisterUnitEvent(4050, 2, "CenarionCaretaker_OnLeaveCombat")
RegisterUnitEvent(4050, 3, "CenarionCaretaker_OnKilledTarget")
RegisterUnitEvent(4050, 4, "CenarionCaretaker_OnDied")