--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function DiseasedDrakkari_OnCombat(Unit, Event)
Unit:RegisterEvent("DiseasedDrakkari_FeveredDisease", 10000, 0)
end

function DiseasedDrakkari_FeveredDisease(Unit, Event) 
Unit:FullCastSpellOnTarget(34363, Unit:GetMainTank()) 
end

function DiseasedDrakkari_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DiseasedDrakkari_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DiseasedDrakkari_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26457, 1, "DiseasedDrakkari_OnCombat")
RegisterUnitEvent(26457, 2, "DiseasedDrakkari_OnLeaveCombat")
RegisterUnitEvent(26457, 3, "DiseasedDrakkari_OnKilledTarget")
RegisterUnitEvent(26457, 4, "DiseasedDrakkari_OnDied")