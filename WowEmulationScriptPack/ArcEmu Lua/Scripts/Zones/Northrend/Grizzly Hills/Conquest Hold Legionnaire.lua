--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ConquestHoldLegionnaire_OnCombat(Unit, Event)
Unit:RegisterEvent("ConquestHoldLegionnaire_DemoralizingShout", 3000, 1)
Unit:RegisterEvent("ConquestHoldLegionnaire_Hamstring", 10000, 0)
end

function ConquestHoldLegionnaire_DemoralizingShout(Unit, Event) 
Unit:CastSpell(61044) 
end

function ConquestHoldLegionnaire_Hamstring(Unit, Event) 
Unit:FullCastSpellOnTarget(9080, Unit:GetMainTank()) 
end

function ConquestHoldLegionnaire_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ConquestHoldLegionnaire_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ConquestHoldLegionnaire_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26839, 1, "ConquestHoldLegionnaire_OnCombat")
RegisterUnitEvent(26839, 2, "ConquestHoldLegionnaire_OnLeaveCombat")
RegisterUnitEvent(26839, 3, "ConquestHoldLegionnaire_OnKilledTarget")
RegisterUnitEvent(26839, 4, "ConquestHoldLegionnaire_OnDied")