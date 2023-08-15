--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WestfallBrigadeHunter_OnCombat(Unit, Event)
Unit:RegisterEvent("WestfallBrigadeHunter_AimedShot", 7000, 0)
end

function WestfallBrigadeHunter_AimedShot(Unit, Event) 
Unit:FullCastSpellOnTarget(38861, Unit:GetMainTank()) 
end

function WestfallBrigadeHunter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WestfallBrigadeHunter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WestfallBrigadeHunter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27462, 1, "WestfallBrigadeHunter_OnCombat")
RegisterUnitEvent(27462, 2, "WestfallBrigadeHunter_OnLeaveCombat")
RegisterUnitEvent(27462, 3, "WestfallBrigadeHunter_OnKilledTarget")
RegisterUnitEvent(27462, 4, "WestfallBrigadeHunter_OnDied")