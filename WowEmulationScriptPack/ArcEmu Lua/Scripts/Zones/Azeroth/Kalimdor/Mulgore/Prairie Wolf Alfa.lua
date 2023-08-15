--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function PrairieWolfAlfa_OnCombat(Unit, Event)
Unit:RegisterEvent("PrairieWolfAlfa_ThreateningGrowl", 10000, 2)
end

function PrairieWolfAlfa_ThreateningGrowl(pUnit, Event) 
pUnit:FullCastSpellOnTarget(5781, pUnit:GetMainTank()) 
end

function PrairieWolfAlfa_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function PrairieWolfAlfa_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function PrairieWolfAlfa_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2960, 1, "PrairieWolfAlfa_OnCombat")
RegisterUnitEvent(2960, 2, "PrairieWolfAlfa_OnLeaveCombat")
RegisterUnitEvent(2960, 3, "PrairieWolfAlfa_OnKilledTarget")
RegisterUnitEvent(2960, 4, "PrairieWolfAlfa_OnDied")