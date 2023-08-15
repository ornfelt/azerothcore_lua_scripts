--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ScorpidDuneburrower_OnCombat(Unit, Event)
	Unit:RegisterEvent("ScorpidDuneburrower_VenomSting", 10000, 0)
end

function ScorpidDuneburrower_VenomSting(Unit, Event) 
	Unit:FullCastSpellOnTarget(5416, 	Unit:GetMainTank()) 
end

function ScorpidDuneburrower_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ScorpidDuneburrower_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function ScorpidDuneburrower_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(7803, 1, "ScorpidDuneburrower_OnCombat")
RegisterUnitEvent(7803, 2, "ScorpidDuneburrower_OnLeaveCombat")
RegisterUnitEvent(7803, 3, "ScorpidDuneburrower_OnKilledTarget")
RegisterUnitEvent(7803, 4, "ScorpidDuneburrower_OnDied")