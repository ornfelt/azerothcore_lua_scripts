--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function FordragonSentinel_OnCombat(Unit, Event)
Unit:RegisterEvent("FordragonSentinel_GlaiveThrow", 8000, 0)
end

function FordragonSentinel_GlaiveThrow(Unit, Event) 
Unit:FullCastSpellOnTarget(49481, Unit:GetMainTank()) 
end

function FordragonSentinel_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FordragonSentinel_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FordragonSentinel_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27576, 1, "FordragonSentinel_OnCombat")
RegisterUnitEvent(27576, 2, "FordragonSentinel_OnLeaveCombat")
RegisterUnitEvent(27576, 3, "FordragonSentinel_OnKilledTarget")
RegisterUnitEvent(27576, 4, "FordragonSentinel_OnDied")