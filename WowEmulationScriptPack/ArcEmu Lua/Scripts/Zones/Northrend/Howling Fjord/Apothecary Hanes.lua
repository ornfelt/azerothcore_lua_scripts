--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ApothecaryHanes_OnCombat(Unit, Event)
Unit:RegisterEvent("ApothecaryHanes_HealingPotion", 12000, 0)
end

function ApothecaryHanes_HealingPotion(Unit, Event) 
Unit:CastSpell(17534) 
end

function ApothecaryHanes_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ApothecaryHanes_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ApothecaryHanes_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(23784, 1, "ApothecaryHanes_OnCombat")
RegisterUnitEvent(23784, 2, "ApothecaryHanes_OnLeaveCombat")
RegisterUnitEvent(23784, 3, "ApothecaryHanes_OnKilledTarget")
RegisterUnitEvent(23784, 4, "ApothecaryHanes_OnDied")