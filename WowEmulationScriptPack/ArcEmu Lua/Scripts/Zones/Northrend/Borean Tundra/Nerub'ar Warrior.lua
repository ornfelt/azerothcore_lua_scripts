--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function NerubarWarrior_OnCombat(Unit, Event)
Unit:RegisterEvent("NerubarWarrior_Rush", 8000, 0)
end

function NerubarWarrior_Rush(Unit, Event) 
Unit:CastSpell(50347) 
end

function NerubarWarrior_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NerubarWarrior_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NerubarWarrior_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25619, 1, "NerubarWarrior_OnCombat")
RegisterUnitEvent(25619, 2, "NerubarWarrior_OnLeaveCombat")
RegisterUnitEvent(25619, 3, "NerubarWarrior_OnKilledTarget")
RegisterUnitEvent(25619, 4, "NerubarWarrior_OnDied")