--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Bambina_OnCombat(Unit, Event)
Unit:RegisterEvent("Bambina_BambinasVengeance", 4000, 1)
end

function Bambina_BambinasVengeance(Unit, Event) 
Unit:CastSpell(48869) 
end

function Bambina_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Bambina_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Bambina_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27461, 1, "Bambina_OnCombat")
RegisterUnitEvent(27461, 2, "Bambina_OnLeaveCombat")
RegisterUnitEvent(27461, 3, "Bambina_OnKilledTarget")
RegisterUnitEvent(27461, 4, "Bambina_OnDied")