--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Scoodles_OnCombat(Unit, Event)
Unit:RegisterEvent("Scoodles_FlipperThwack", 7000, 0)
Unit:RegisterEvent("Scoodles_PowerfulBite", 6000, 0)
end

function Scoodles_FlipperThwack(Unit, Event) 
Unit:FullCastSpellOnTarget(50169, Unit:GetMainTank()) 
end

function Scoodles_PowerfulBite(Unit, Event) 
Unit:FullCastSpellOnTarget(48287, Unit:GetMainTank()) 
end

function Scoodles_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Scoodles_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Scoodles_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24899, 1, "Scoodles_OnCombat")
RegisterUnitEvent(24899, 2, "Scoodles_OnLeaveCombat")
RegisterUnitEvent(24899, 3, "Scoodles_OnKilledTarget")
RegisterUnitEvent(24899, 4, "Scoodles_OnDied")