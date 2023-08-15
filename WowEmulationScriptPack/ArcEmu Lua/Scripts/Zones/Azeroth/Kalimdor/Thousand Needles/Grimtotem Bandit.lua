--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GrimtotemBandit_OnCombat(Unit, Event)
	UnitRegisterEvent("GrimtotemBandit_Disarm", 8000, 0)
	UnitRegisterEvent("GrimtotemBandit_Kick", 9000, 0)
end

function GrimtotemBandit_Disarm(Unit, Event) 
	UnitFullCastSpellOnTarget(6713, 	UnitGetMainTank()) 
end

function GrimtotemBandit_Kick(Unit, Event) 
	UnitFullCastSpellOnTarget(11978, 	UnitGetMainTank()) 
end

function GrimtotemBandit_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function GrimtotemBandit_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function GrimtotemBandit_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(10758, 1, "GrimtotemBandit_OnCombat")
RegisterUnitEvent(10758, 2, "GrimtotemBandit_OnLeaveCombat")
RegisterUnitEvent(10758, 3, "GrimtotemBandit_OnKilledTarget")
RegisterUnitEvent(10758, 4, "GrimtotemBandit_OnDied")