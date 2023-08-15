--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GorlocDredger_OnCombat(Unit, Event)
Unit:RegisterEvent("GorlocDredger_DeepDredge", 6000, 0)
Unit:RegisterEvent("GorlocDredger_Whirlwind", 9000, 0)
end

function GorlocDredger_DeepDredge(Unit, Event) 
Unit:CastSpell(50520) 
end

function GorlocDredger_Whirlwind(Unit, Event) 
Unit:CastSpell(15576) 
end

function GorlocDredger_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GorlocDredger_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GorlocDredger_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25701, 1, "GorlocDredger_OnCombat")
RegisterUnitEvent(25701, 2, "GorlocDredger_OnLeaveCombat")
RegisterUnitEvent(25701, 3, "GorlocDredger_OnKilledTarget")
RegisterUnitEvent(25701, 4, "GorlocDredger_OnDied")