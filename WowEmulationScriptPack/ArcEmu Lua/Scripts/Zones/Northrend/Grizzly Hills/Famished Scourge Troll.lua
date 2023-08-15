--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function FamishedScourgeTroll_OnCombat(Unit, Event)
Unit:RegisterEvent("FamishedScourgeTroll_Suicide", 30000, 1)
end

function FamishedScourgeTroll_Suicide(Unit, Event) 
Unit:CastSpell(7) 
end

function FamishedScourgeTroll_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FamishedScourgeTroll_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FamishedScourgeTroll_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26570, 1, "FamishedScourgeTroll_OnCombat")
RegisterUnitEvent(26570, 2, "FamishedScourgeTroll_OnLeaveCombat")
RegisterUnitEvent(26570, 3, "FamishedScourgeTroll_OnKilledTarget")
RegisterUnitEvent(26570, 4, "FamishedScourgeTroll_OnDied")