--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BoilingSpirit_OnCombat(Unit, Event)
Unit:RegisterEvent("BoilingSpirit_ScaldingSteam", 8000, 0)
end

function BoilingSpirit_ScaldingSteam(Unit, Event) 
Unit:FullCastSpellOnTarget(50206, Unit:GetMainTank()) 
end

function BoilingSpirit_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BoilingSpirit_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BoilingSpirit_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25419, 1, "BoilingSpirit_OnCombat")
RegisterUnitEvent(25419, 2, "BoilingSpirit_OnLeaveCombat")
RegisterUnitEvent(25419, 3, "BoilingSpirit_OnKilledTarget")
RegisterUnitEvent(25419, 4, "BoilingSpirit_OnDied")