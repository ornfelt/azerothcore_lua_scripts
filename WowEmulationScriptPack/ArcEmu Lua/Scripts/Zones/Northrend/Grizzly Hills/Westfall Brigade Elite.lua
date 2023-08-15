--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WestfallBrigadeElite_OnCombat(Unit, Event)
Unit:RegisterEvent("WestfallBrigadeElite_Hamstring", 10000, 0)
Unit:RegisterEvent("WestfallBrigadeElite_Strike", 8000, 0)
end

function WestfallBrigadeElite_Hamstring(Unit, Event) 
Unit:FullCastSpellOnTarget(9080, Unit:GetMainTank()) 
end

function WestfallBrigadeElite_Strike(Unit, Event) 
Unit:FullCastSpellOnTarget(11976, Unit:GetMainTank()) 
end

function WestfallBrigadeElite_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WestfallBrigadeElite_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WestfallBrigadeElite_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27549, 1, "WestfallBrigadeElite_OnCombat")
RegisterUnitEvent(27549, 2, "WestfallBrigadeElite_OnLeaveCombat")
RegisterUnitEvent(27549, 3, "WestfallBrigadeElite_OnKilledTarget")
RegisterUnitEvent(27549, 4, "WestfallBrigadeElite_OnDied")