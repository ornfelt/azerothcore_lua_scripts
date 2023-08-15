--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WestfallBrigadeDefender_OnCombat(Unit, Event)
Unit:RegisterEvent("WestfallBrigadeDefender_Strike", 6000, 0)
end

function WestfallBrigadeDefender_Strike(Unit, Event) 
Unit:FullCastSpellOnTarget(14516, Unit:GetMainTank()) 
end

function WestfallBrigadeDefender_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WestfallBrigadeDefender_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WestfallBrigadeDefender_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27758, 1, "WestfallBrigadeDefender_OnCombat")
RegisterUnitEvent(27758, 2, "WestfallBrigadeDefender_OnLeaveCombat")
RegisterUnitEvent(27758, 3, "WestfallBrigadeDefender_OnKilledTarget")
RegisterUnitEvent(27758, 4, "WestfallBrigadeDefender_OnDied")