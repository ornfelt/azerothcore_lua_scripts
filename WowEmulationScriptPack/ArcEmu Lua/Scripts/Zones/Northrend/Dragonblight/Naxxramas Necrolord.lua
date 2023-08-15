--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function NaxxramasNecrolord_OnCombat(Unit, Event)
Unit:RegisterEvent("NaxxramasNecrolord_ChaosBolt", 6000, 0)
end

function NaxxramasNecrolord_ChaosBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(51287, Unit:GetMainTank()) 
end

function NaxxramasNecrolord_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NaxxramasNecrolord_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NaxxramasNecrolord_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27289, 1, "NaxxramasNecrolord_OnCombat")
RegisterUnitEvent(27289, 2, "NaxxramasNecrolord_OnLeaveCombat")
RegisterUnitEvent(27289, 3, "NaxxramasNecrolord_OnKilledTarget")
RegisterUnitEvent(27289, 4, "NaxxramasNecrolord_OnDied")