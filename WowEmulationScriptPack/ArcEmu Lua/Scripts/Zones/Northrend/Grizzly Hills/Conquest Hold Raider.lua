--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ConquestHoldRaider_OnCombat(Unit, Event)
Unit:RegisterEvent("ConquestHoldRaider_DemoralizingShout", 3000, 1)
Unit:RegisterEvent("ConquestHoldRaider_HeroicStrike", 5000, 0)
Unit:RegisterEvent("ConquestHoldRaider_Intercept", 9000, 0)
end

function ConquestHoldRaider_DemoralizingShout(Unit, Event) 
Unit:CastSpell(13730) 
end

function ConquestHoldRaider_HeroicStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(25710, Unit:GetMainTank()) 
end

function ConquestHoldRaider_Intercept(Unit, Event) 
Unit:FullCastSpellOnTarget(27577, Unit:GetMainTank()) 
end

function ConquestHoldRaider_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ConquestHoldRaider_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ConquestHoldRaider_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27118, 1, "ConquestHoldRaider_OnCombat")
RegisterUnitEvent(27118, 2, "ConquestHoldRaider_OnLeaveCombat")
RegisterUnitEvent(27118, 3, "ConquestHoldRaider_OnKilledTarget")
RegisterUnitEvent(27118, 4, "ConquestHoldRaider_OnDied")