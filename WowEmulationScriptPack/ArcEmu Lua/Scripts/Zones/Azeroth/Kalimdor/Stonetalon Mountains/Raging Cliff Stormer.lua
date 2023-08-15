--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function RagingCliffStormer_OnCombat(Unit, Event)
	UnitRegisterEvent("RagingCliffStormer_RushingCharge", 10000, 0)
	UnitRegisterEvent("RagingCliffStormer_Thunderclap", 6000, 0)
end

function RagingCliffStormer_RushingCharge(Unit, Event) 
	UnitCastSpell(6268) 
end

function RagingCliffStormer_Thunderclap(Unit, Event) 
	UnitFullCastSpellOnTarget(8078, 	UnitGetMainTank()) 
end

function RagingCliffStormer_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function RagingCliffStormer_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function RagingCliffStormer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4009, 1, "RagingCliffStormer_OnCombat")
RegisterUnitEvent(4009, 2, "RagingCliffStormer_OnLeaveCombat")
RegisterUnitEvent(4009, 3, "RagingCliffStormer_OnKilledTarget")
RegisterUnitEvent(4009, 4, "RagingCliffStormer_OnDied")