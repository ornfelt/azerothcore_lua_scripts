--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function IronRuneOverseer_OnCombat(Unit, Event)
Unit:RegisterEvent("IronRuneOverseer_CallLightning", 6000, 0)
end

function IronRuneOverseer_CallLightning(Unit, Event) 
Unit:FullCastSpellOnTarget(32018, Unit:GetMainTank()) 
end

function IronRuneOverseer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IronRuneOverseer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IronRuneOverseer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27177, 1, "IronRuneOverseer_OnCombat")
RegisterUnitEvent(27177, 2, "IronRuneOverseer_OnLeaveCombat")
RegisterUnitEvent(27177, 3, "IronRuneOverseer_OnKilledTarget")
RegisterUnitEvent(27177, 4, "IronRuneOverseer_OnDied")