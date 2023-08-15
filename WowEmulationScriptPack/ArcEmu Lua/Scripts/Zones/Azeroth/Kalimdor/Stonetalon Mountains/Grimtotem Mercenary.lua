--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GrimtotemMercenary_OnCombat(Unit, Event)
	UnitRegisterEvent("GrimtotemMercenary_Pummel", 10000, 0)
	UnitRegisterEvent("GrimtotemMercenary_Throw", 6000, 0)
end

function GrimtotemMercenary_Pummel(Unit, Event) 
	UnitFullCastSpellOnTarget(12555, 	UnitGetMainTank()) 
end

function GrimtotemMercenary_Throw(Unit, Event) 
	UnitFullCastSpellOnTarget(15607, 	UnitGetMainTank()) 
end

function GrimtotemMercenary_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function GrimtotemMercenary_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function GrimtotemMercenary_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11911, 1, "GrimtotemMercenary_OnCombat")
RegisterUnitEvent(11911, 2, "GrimtotemMercenary_OnLeaveCombat")
RegisterUnitEvent(11911, 3, "GrimtotemMercenary_OnKilledTarget")
RegisterUnitEvent(11911, 4, "GrimtotemMercenary_OnDied")