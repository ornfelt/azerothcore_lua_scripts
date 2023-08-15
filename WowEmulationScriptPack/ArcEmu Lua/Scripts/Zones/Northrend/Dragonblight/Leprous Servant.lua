--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function LeprousServant_OnCombat(Unit, Event)
Unit:RegisterEvent("LeprousServant_LeprousTouch", 8000, 0)
end

function LeprousServant_LeprousTouch(Unit, Event) 
Unit:FullCastSpellOnTarget(51315, Unit:GetMainTank()) 
end

function LeprousServant_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function LeprousServant_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function LeprousServant_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27800, 1, "LeprousServant_OnCombat")
RegisterUnitEvent(27800, 2, "LeprousServant_OnLeaveCombat")
RegisterUnitEvent(27800, 3, "LeprousServant_OnKilledTarget")
RegisterUnitEvent(27800, 4, "LeprousServant_OnDied")