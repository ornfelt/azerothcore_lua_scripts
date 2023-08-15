--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CaldemereSnapper_OnCombat(Unit, Event)
Unit:RegisterEvent("CaldemereSnapper_ClawGrasp", 10000, 0)
end

function CaldemereSnapper_ClawGrasp(Unit, Event) 
Unit:FullCastSpellOnTarget(49978, Unit:GetMainTank()) 
end

function CaldemereSnapper_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CaldemereSnapper_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CaldemereSnapper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24287, 1, "CaldemereSnapper_OnCombat")
RegisterUnitEvent(24287, 2, "CaldemereSnapper_OnLeaveCombat")
RegisterUnitEvent(24287, 3, "CaldemereSnapper_OnKilledTarget")
RegisterUnitEvent(24287, 4, "CaldemereSnapper_OnDied")