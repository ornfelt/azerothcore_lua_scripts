--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Selas_OnCombat(Unit, Event)
Unit:RegisterEvent("Selas_AxeVolley", 6000, 0)
Unit:RegisterEvent("Selas_KillingRage", 5000, 0)
end

function Selas_AxeVolley(Unit, Event) 
Unit:CastSpell(53239) 
end

function Selas_KillingRage(Unit, Event) 
Unit:CastSpell(52071) 
end

function Selas_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Selas_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Selas_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27580, 1, "Selas_OnCombat")
RegisterUnitEvent(27580, 2, "Selas_OnLeaveCombat")
RegisterUnitEvent(27580, 3, "Selas_OnKilledTarget")
RegisterUnitEvent(27580, 4, "Selas_OnDied")