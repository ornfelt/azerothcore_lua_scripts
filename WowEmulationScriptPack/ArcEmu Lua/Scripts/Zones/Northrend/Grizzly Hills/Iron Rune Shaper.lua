--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function IronRuneShaper_OnCombat(Unit, Event)
Unit:RegisterEvent("IronRuneShaper_MoldRune", 3000, 1)
end

function IronRuneShaper_MoldRune(Unit, Event) 
Unit:CastSpell(52622) 
end

function IronRuneShaper_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IronRuneShaper_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IronRuneShaper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26270, 1, "IronRuneShaper_OnCombat")
RegisterUnitEvent(26270, 2, "IronRuneShaper_OnLeaveCombat")
RegisterUnitEvent(26270, 3, "IronRuneShaper_OnKilledTarget")
RegisterUnitEvent(26270, 4, "IronRuneShaper_OnDied")