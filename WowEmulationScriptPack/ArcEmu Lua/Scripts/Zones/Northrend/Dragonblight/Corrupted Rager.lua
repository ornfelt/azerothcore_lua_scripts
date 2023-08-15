--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CorruptedRager_OnCombat(Unit, Event)
Unit:RegisterEvent("CorruptedRager_CorrodeArmor", 8000, 0)
end

function CorruptedRager_CorrodeArmor(Unit, Event) 
Unit:FullCastSpellOnTarget(51613, Unit:GetMainTank()) 
end

function CorruptedRager_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CorruptedRager_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CorruptedRager_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(21223, 1, "CorruptedRager_OnCombat")
RegisterUnitEvent(21223, 2, "CorruptedRager_OnLeaveCombat")
RegisterUnitEvent(21223, 3, "CorruptedRager_OnKilledTarget")
RegisterUnitEvent(21223, 4, "CorruptedRager_OnDied")