--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CorruptedScorpid_OnCombat(Unit, Event)
	UnitRegisterEvent("CorruptedScorpid_NoxiousCatalyst", 10000, 0)
end

function CorruptedScorpid_NoxiousCatalyst(Unit, Event) 
	UnitFullCastSpellOnTarget(5413, 	UnitGetMainTank()) 
end

function CorruptedScorpid_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function CorruptedScorpid_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function CorruptedScorpid_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3226, 1, "CorruptedScorpid_OnCombat")
RegisterUnitEvent(3226, 2, "CorruptedScorpid_OnLeaveCombat")
RegisterUnitEvent(3226, 3, "CorruptedScorpid_OnKilledTarget")
RegisterUnitEvent(3226, 4, "CorruptedScorpid_OnDied")