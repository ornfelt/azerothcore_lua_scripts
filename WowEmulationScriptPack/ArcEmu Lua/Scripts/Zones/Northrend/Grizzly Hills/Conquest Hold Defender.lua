--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ConquestHoldDefender_OnCombat(Unit, Event)
Unit:RegisterEvent("ConquestHoldDefender_HeroicStrike", 5000, 0)
end

function ConquestHoldDefender_HeroicStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(29426, Unit:GetMainTank()) 
end

function ConquestHoldDefender_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ConquestHoldDefender_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ConquestHoldDefender_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27748, 1, "ConquestHoldDefender_OnCombat")
RegisterUnitEvent(27748, 2, "ConquestHoldDefender_OnLeaveCombat")
RegisterUnitEvent(27748, 3, "ConquestHoldDefender_OnKilledTarget")
RegisterUnitEvent(27748, 4, "ConquestHoldDefender_OnDied")