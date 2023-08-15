--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function IronRuneAvenger_OnCombat(Unit, Event)
Unit:RegisterEvent("IronRuneAvenger_RuneofRetribution", 3000, 1)
end

function IronRuneAvenger_RuneofRetribution(Unit, Event) 
Unit:CastSpell(52628) 
end

function IronRuneAvenger_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IronRuneAvenger_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IronRuneAvenger_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26786, 1, "IronRuneAvenger_OnCombat")
RegisterUnitEvent(26786, 2, "IronRuneAvenger_OnLeaveCombat")
RegisterUnitEvent(26786, 3, "IronRuneAvenger_OnKilledTarget")
RegisterUnitEvent(26786, 4, "IronRuneAvenger_OnDied")