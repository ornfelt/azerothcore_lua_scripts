--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function InfiniteEradicator_OnCombat(Unit, Event)
Unit:RegisterEvent("InfiniteEradicator_Hasten", 2000, 1)
Unit:RegisterEvent("InfiniteEradicator_TemporalVortex", 6000, 0)
Unit:RegisterEvent("InfiniteEradicator_WingBuffet", 8000, 0)
end

function InfiniteEradicator_Hasten(Unit, Event) 
Unit:CastSpell(31458) 
end

function InfiniteEradicator_TemporalVortex(Unit, Event) 
Unit:FullCastSpellOnTarget(52657, Unit:GetMainTank()) 
end

function InfiniteEradicator_WingBuffet(Unit, Event) 
Unit:CastSpell(31475) 
end

function InfiniteEradicator_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InfiniteEradicator_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InfiniteEradicator_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32185, 1, "InfiniteEradicator_OnCombat")
RegisterUnitEvent(32185, 2, "InfiniteEradicator_OnLeaveCombat")
RegisterUnitEvent(32185, 3, "InfiniteEradicator_OnKilledTarget")
RegisterUnitEvent(32185, 4, "InfiniteEradicator_OnDied")