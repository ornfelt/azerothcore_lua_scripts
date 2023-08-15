--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ScourgeSiegesmith_OnCombat(Unit, Event)
Unit:RegisterEvent("ScourgeSiegesmith_Bomb", 5500, 0)
end

function ScourgeSiegesmith_Bomb(Unit, Event) 
Unit:CastSpell(22334) 
end

function ScourgeSiegesmith_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ScourgeSiegesmith_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ScourgeSiegesmith_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27410, 1, "ScourgeSiegesmith_OnCombat")
RegisterUnitEvent(27410, 2, "ScourgeSiegesmith_OnLeaveCombat")
RegisterUnitEvent(27410, 3, "ScourgeSiegesmith_OnKilledTarget")
RegisterUnitEvent(27410, 4, "ScourgeSiegesmith_OnDied")