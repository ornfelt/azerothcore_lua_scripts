--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ScorpidTailLasher_OnCombat(Unit, Event)
	Unit:RegisterEvent("ScorpidTailLasher_Lash", 8000, 0)
end

function ScorpidTailLasher_Lash(Unit, Event) 
	Unit:FullCastSpellOnTarget(6607, 	Unit:GetMainTank()) 
end

function ScorpidTailLasher_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ScorpidTailLasher_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function ScorpidTailLasher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5423, 1, "ScorpidTailLasher_OnCombat")
RegisterUnitEvent(5423, 2, "ScorpidTailLasher_OnLeaveCombat")
RegisterUnitEvent(5423, 3, "ScorpidTailLasher_OnKilledTarget")
RegisterUnitEvent(5423, 4, "ScorpidTailLasher_OnDied")