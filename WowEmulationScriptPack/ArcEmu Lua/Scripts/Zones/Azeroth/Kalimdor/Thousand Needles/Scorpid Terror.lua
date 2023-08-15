--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ScorpidTerror_OnCombat(Unit, Event)
	UnitRegisterEvent("ScorpidTerror_Terrify", 10000, 0)
end

function ScorpidTerror_Terrify(Unit, Event) 
	UnitFullCastSpellOnTarget(7399, 	UnitGetMainTank()) 
end

function ScorpidTerror_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function ScorpidTerror_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function ScorpidTerror_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4139, 1, "ScorpidTerror_OnCombat")
RegisterUnitEvent(4139, 2, "ScorpidTerror_OnLeaveCombat")
RegisterUnitEvent(4139, 3, "ScorpidTerror_OnKilledTarget")
RegisterUnitEvent(4139, 4, "ScorpidTerror_OnDied")