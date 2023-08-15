--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BlightedElk_OnCombat(Unit, Event)
Unit:RegisterEvent("BlightedElk_PlagueBlight", 8000, 0)
end

function BlightedElk_PlagueBlight(Unit, Event) 
Unit:FullCastSpellOnTarget(43506, Unit:GetMainTank()) 
end

function BlightedElk_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BlightedElk_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BlightedElk_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26616, 1, "BlightedElk_OnCombat")
RegisterUnitEvent(26616, 2, "BlightedElk_OnLeaveCombat")
RegisterUnitEvent(26616, 3, "BlightedElk_OnKilledTarget")
RegisterUnitEvent(26616, 4, "BlightedElk_OnDied")