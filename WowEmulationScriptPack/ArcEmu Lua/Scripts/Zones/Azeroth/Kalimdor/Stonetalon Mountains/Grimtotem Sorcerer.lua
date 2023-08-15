--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GrimtotemSorcerer_OnCombat(Unit, Event)
	UnitRegisterEvent("GrimtotemSorcerer_LightningBolt", 8000, 0)
	UnitRegisterEvent("GrimtotemSorcerer_Rejuvenation", 12000, 0)
end

function GrimtotemSorcerer_LightningBolt(Unit, Event) 
	UnitFullCastSpellOnTarget(20802, 	UnitGetMainTank()) 
end

function GrimtotemSorcerer_Rejuvenation(Unit, Event) 
	UnitCastSpell(12160) 
end

function GrimtotemSorcerer_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function GrimtotemSorcerer_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function GrimtotemSorcerer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11913, 1, "GrimtotemSorcerer_OnCombat")
RegisterUnitEvent(11913, 2, "GrimtotemSorcerer_OnLeaveCombat")
RegisterUnitEvent(11913, 3, "GrimtotemSorcerer_OnKilledTarget")
RegisterUnitEvent(11913, 4, "GrimtotemSorcerer_OnDied")