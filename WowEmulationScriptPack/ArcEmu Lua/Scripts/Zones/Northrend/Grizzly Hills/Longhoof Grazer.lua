--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function LonghoofGrazer_OnCombat(Unit, Event)
Unit:RegisterEvent("LonghoofGrazer_HeadButt", 8000, 0)
end

function LonghoofGrazer_HeadButt(Unit, Event) 
Unit:FullCastSpellOnTarget(42320, Unit:GetMainTank()) 
end

function LonghoofGrazer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function LonghoofGrazer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function LonghoofGrazer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26418, 1, "LonghoofGrazer_OnCombat")
RegisterUnitEvent(26418, 2, "LonghoofGrazer_OnLeaveCombat")
RegisterUnitEvent(26418, 3, "LonghoofGrazer_OnKilledTarget")
RegisterUnitEvent(26418, 4, "LonghoofGrazer_OnDied")