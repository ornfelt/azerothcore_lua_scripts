--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function FordragonKnight_OnCombat(Unit, Event)
Unit:RegisterEvent("FordragonKnight_RallyingCry", 2000, 1)
end

function FordragonKnight_RallyingCry(Unit, Event) 
Unit:CastSpell(31732) 
end

function FordragonKnight_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FordragonKnight_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FordragonKnight_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27531, 1, "FordragonKnight_OnCombat")
RegisterUnitEvent(27531, 2, "FordragonKnight_OnLeaveCombat")
RegisterUnitEvent(27531, 3, "FordragonKnight_OnKilledTarget")
RegisterUnitEvent(27531, 4, "FordragonKnight_OnDied")