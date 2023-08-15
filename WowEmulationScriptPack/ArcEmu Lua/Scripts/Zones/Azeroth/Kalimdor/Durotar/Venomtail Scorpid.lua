--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function VenomtailScorpid_OnCombat(Unit, Event)
	Unit:RegisterEvent("VenomtailScorpid_VenomSting", 10000, 0)
end

function VenomtailScorpid_VenomSting(Unit, Event) 
	Unit:FullCastSpellOnTarget(5416, 	Unit:GetMainTank()) 
end

function VenomtailScorpid_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function VenomtailScorpid_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function VenomtailScorpid_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3127, 1, "VenomtailScorpid_OnCombat")
RegisterUnitEvent(3127, 2, "VenomtailScorpid_OnLeaveCombat")
RegisterUnitEvent(3127, 3, "VenomtailScorpid_OnKilledTarget")
RegisterUnitEvent(3127, 4, "VenomtailScorpid_OnDied")