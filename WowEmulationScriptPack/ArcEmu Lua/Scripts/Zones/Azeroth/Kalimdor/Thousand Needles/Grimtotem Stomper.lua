--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GrimtotemStomper_OnCombat(Unit, Event)
	UnitRegisterEvent("GrimtotemStomper_EarthShock", 4000, 0)
	UnitRegisterEvent("GrimtotemReaver_HealingWard", 8000, 0)
end

function GrimtotemStomper_EarthShock(Unit, Event) 
	UnitFullCastSpellOnTarget(13281, 	UnitGetMainTank()) 
end

function GrimtotemReaver_HealingWard(Unit, Event) 
	UnitCastSpell(5605) 
end

function GrimtotemStomper_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function GrimtotemStomper_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function GrimtotemStomper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(10759, 1, "GrimtotemStomper_OnCombat")
RegisterUnitEvent(10759, 2, "GrimtotemStomper_OnLeaveCombat")
RegisterUnitEvent(10759, 3, "GrimtotemStomper_OnKilledTarget")
RegisterUnitEvent(10759, 4, "GrimtotemStomper_OnDied")