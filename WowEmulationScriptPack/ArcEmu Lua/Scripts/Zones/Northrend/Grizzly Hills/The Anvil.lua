--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TheAnvi_OnCombat(Unit, Event)
Unit:RegisterEvent("TheAnvi_MoltenBlast", 8000, 0)
end

function TheAnvi_MoltenBlast(Unit, Event) 
Unit:CastSpell(61577) 
end

function TheAnvi_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TheAnvi_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TheAnvi_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26406, 1, "TheAnvi_OnCombat")
RegisterUnitEvent(26406, 2, "TheAnvi_OnLeaveCombat")
RegisterUnitEvent(26406, 3, "TheAnvi_OnKilledTarget")
RegisterUnitEvent(26406, 4, "TheAnvi_OnDied")