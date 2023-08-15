--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ConquestHoldGrunt_OnCombat(Unit, Event)
Unit:RegisterEvent("ConquestHoldGrunt_DemoralizingShout", 3000, 1)
Unit:RegisterEvent("ConquestHoldGrunt_HeroicStrike", 5000, 0)
Unit:RegisterEvent("ConquestHoldGrunt_Intercept", 9000, 0)
end

function ConquestHoldGrunt_DemoralizingShout(Unit, Event) 
Unit:CastSpell(13730) 
end

function ConquestHoldGrunt_HeroicStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(25710, Unit:GetMainTank()) 
end

function ConquestHoldGrunt_Intercept(Unit, Event) 
Unit:FullCastSpellOnTarget(27577, Unit:GetMainTank()) 
end

function ConquestHoldGrunt_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ConquestHoldGrunt_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ConquestHoldGrunt_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27470, 1, "ConquestHoldGrunt_OnCombat")
RegisterUnitEvent(27470, 2, "ConquestHoldGrunt_OnLeaveCombat")
RegisterUnitEvent(27470, 3, "ConquestHoldGrunt_OnKilledTarget")
RegisterUnitEvent(27470, 4, "ConquestHoldGrunt_OnDied")