--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ScorpidDunestalker_OnCombat(Unit, Event)
	Unit:RegisterEvent("ScorpidDunestalker_VenomSting", 10000, 0)
end

function ScorpidDunestalker_VenomSting(Unit, Event) 
	Unit:FullCastSpellOnTarget(5416, 	Unit:GetMainTank()) 
end

function ScorpidDunestalker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ScorpidDunestalker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function ScorpidDunestalker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5424, 1, "ScorpidDunestalker_OnCombat")
RegisterUnitEvent(5424, 2, "ScorpidDunestalker_OnLeaveCombat")
RegisterUnitEvent(5424, 3, "ScorpidDunestalker_OnKilledTarget")
RegisterUnitEvent(5424, 4, "ScorpidDunestalker_OnDied")