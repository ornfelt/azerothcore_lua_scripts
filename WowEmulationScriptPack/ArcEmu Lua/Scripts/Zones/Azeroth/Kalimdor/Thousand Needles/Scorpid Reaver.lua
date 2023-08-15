--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function ScorpidReaver_OnCombat(Unit, Event)
	UnitRegisterEvent("ScorpidReaver_Cleave", 4000, 0)
end

function ScorpidReaver_Cleave(Unit, Event) 
	UnitCastSpell(40505) 
end

function ScorpidReaver_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function ScorpidReaver_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function ScorpidReaver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4140, 1, "ScorpidReaver_OnCombat")
RegisterUnitEvent(4140, 2, "ScorpidReaver_OnLeaveCombat")
RegisterUnitEvent(4140, 3, "ScorpidReaver_OnKilledTarget")
RegisterUnitEvent(4140, 4, "ScorpidReaver_OnDied")