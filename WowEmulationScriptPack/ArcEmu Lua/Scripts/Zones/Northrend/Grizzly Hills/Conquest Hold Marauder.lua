--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ConquestHoldMarauder_OnCombat(Unit, Event)
Unit:RegisterEvent("ConquestHoldMarauder_DemoralizingShout", 3000, 1)
Unit:RegisterEvent("ConquestHoldMarauder_HeroicStrike", 5000, 0)
Unit:RegisterEvent("ConquestHoldMarauder_Intercept", 9000, 0)
end

function ConquestHoldMarauder_DemoralizingShout(Unit, Event) 
Unit:CastSpell(13730) 
end

function ConquestHoldMarauder_HeroicStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(25710, Unit:GetMainTank()) 
end

function ConquestHoldMarauder_Intercept(Unit, Event) 
Unit:FullCastSpellOnTarget(27577, Unit:GetMainTank()) 
end

function ConquestHoldMarauder_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ConquestHoldMarauder_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ConquestHoldMarauder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27424, 1, "ConquestHoldMarauder_OnCombat")
RegisterUnitEvent(27424, 2, "ConquestHoldMarauder_OnLeaveCombat")
RegisterUnitEvent(27424, 3, "ConquestHoldMarauder_OnKilledTarget")
RegisterUnitEvent(27424, 4, "ConquestHoldMarauder_OnDied")