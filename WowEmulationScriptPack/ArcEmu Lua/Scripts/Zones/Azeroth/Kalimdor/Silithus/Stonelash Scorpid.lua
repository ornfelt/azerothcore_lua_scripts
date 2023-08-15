--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function StonelashScorpid_OnCombat(Unit, Event)
	Unit:RegisterEvent("StonelashScorpid_VenomSting", 8000, 0)
end

function StonelashScorpid_VenomSting(Unit, Event) 
	Unit:FullCastSpellOnTarget(5416, 	Unit:GetMainTank()) 
end

function StonelashScorpid_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function StonelashScorpid_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function StonelashScorpid_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11735, 1, "StonelashScorpid_OnCombat")
RegisterUnitEvent(11735, 2, "StonelashScorpid_OnLeaveCombat")
RegisterUnitEvent(11735, 3, "StonelashScorpid_OnKilledTarget")
RegisterUnitEvent(11735, 4, "StonelashScorpid_OnDied")