--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GrimtotemBrute_OnCombat(Unit, Event)
	UnitRegisterEvent("GrimtotemBrute_RushingCharge", 8000, 0)
end

function GrimtotemBrute_RushingCharge(Unit, Event) 
	UnitCastSpell(6268) 
end

function GrimtotemBrute_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function GrimtotemBrute_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function GrimtotemBrute_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11912, 1, "GrimtotemBrute_OnCombat")
RegisterUnitEvent(11912, 2, "GrimtotemBrute_OnLeaveCombat")
RegisterUnitEvent(11912, 3, "GrimtotemBrute_OnKilledTarget")
RegisterUnitEvent(11912, 4, "GrimtotemBrute_OnDied")