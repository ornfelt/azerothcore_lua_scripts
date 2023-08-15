--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function NorthseaThug_OnCombat(Unit, Event)
Unit:RegisterEvent("NorthseaThug_Crazed", 5000, 1)
end

function NorthseaThug_Crazed(Unit, Event) 
Unit:CastSpell(5915) 
end

function NorthseaThug_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NorthseaThug_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NorthseaThug_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25843, 1, "NorthseaThug_OnCombat")
RegisterUnitEvent(25843, 2, "NorthseaThug_OnLeaveCombat")
RegisterUnitEvent(25843, 3, "NorthseaThug_OnKilledTarget")
RegisterUnitEvent(25843, 4, "NorthseaThug_OnDied")