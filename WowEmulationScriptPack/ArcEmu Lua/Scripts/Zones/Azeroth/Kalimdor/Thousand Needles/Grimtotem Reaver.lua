--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function GrimtotemReaver_OnCombat(Unit, Event)
	UnitRegisterEvent("GrimtotemReaver_Cleave", 4000, 0)
	UnitRegisterEvent("GrimtotemReaver_Strike", 5000, 0)
end

function GrimtotemReaver_Cleave(Unit, Event) 
	UnitCastSpell(15496) 
end

function GrimtotemReaver_Strike(Unit, Event) 
	UnitFullCastSpellOnTarget(11976, 	UnitGetMainTank()) 
end

function GrimtotemReaver_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function GrimtotemReaver_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function GrimtotemReaver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(10761, 1, "GrimtotemReaver_OnCombat")
RegisterUnitEvent(10761, 2, "GrimtotemReaver_OnLeaveCombat")
RegisterUnitEvent(10761, 3, "GrimtotemReaver_OnKilledTarget")
RegisterUnitEvent(10761, 4, "GrimtotemReaver_OnDied")