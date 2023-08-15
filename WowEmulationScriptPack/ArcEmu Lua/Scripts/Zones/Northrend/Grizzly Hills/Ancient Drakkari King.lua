--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AncientDrakkariKing_OnCombat(Unit, Event)
Unit:RegisterEvent("AncientDrakkariKing_DrakkariCurse", 8000, 0)
end

function AncientDrakkariKing_DrakkariCurse(Unit, Event) 
Unit:FullCastSpellOnTarget(52466, Unit:GetMainTank()) 
end

function AncientDrakkariKing_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AncientDrakkariKing_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AncientDrakkariKing_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26871, 1, "AncientDrakkariKing_OnCombat")
RegisterUnitEvent(26871, 2, "AncientDrakkariKing_OnLeaveCombat")
RegisterUnitEvent(26871, 3, "AncientDrakkariKing_OnKilledTarget")
RegisterUnitEvent(26871, 4, "AncientDrakkariKing_OnDied")