--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ScoutCaptainCarter_OnCombat(Unit, Event)
Unit:RegisterEvent("ScoutCaptainCarter_DebilitatingStrike", 7000, 0)
end

function ScoutCaptainCarter_DebilitatingStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(38621, Unit:GetMainTank()) 
end

function ScoutCaptainCarter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ScoutCaptainCarter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ScoutCaptainCarter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27783, 1, "ScoutCaptainCarter_OnCombat")
RegisterUnitEvent(27783, 2, "ScoutCaptainCarter_OnLeaveCombat")
RegisterUnitEvent(27783, 3, "ScoutCaptainCarter_OnKilledTarget")
RegisterUnitEvent(27783, 4, "ScoutCaptainCarter_OnDied")