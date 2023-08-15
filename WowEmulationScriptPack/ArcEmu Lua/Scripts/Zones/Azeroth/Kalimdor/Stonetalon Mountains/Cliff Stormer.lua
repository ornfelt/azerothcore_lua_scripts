--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CliffStormer_OnCombat(Unit, Event)
	UnitRegisterEvent("CliffStormer_LizardBolt", 5000, 0)
end

function CliffStormer_LizardBolt(Unit, Event) 
	UnitFullCastSpellOnTarget(5401, 	UnitGetMainTank()) 
end

function CliffStormer_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function CliffStormer_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function CliffStormer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4008, 1, "CliffStormer_OnCombat")
RegisterUnitEvent(4008, 2, "CliffStormer_OnLeaveCombat")
RegisterUnitEvent(4008, 3, "CliffStormer_OnKilledTarget")
RegisterUnitEvent(4008, 4, "CliffStormer_OnDied")