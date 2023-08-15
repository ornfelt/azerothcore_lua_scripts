--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function TivaxtheBreaker_OnCombat(Unit, Event)
Unit:RegisterEvent("TivaxtheBreaker_FireBlast", 5000, 0)
Unit:RegisterEvent("TivaxtheBreaker_Scorch", 6000, 0)
end

function TivaxtheBreaker_FireBlast(Unit, Event) 
Unit:FullCastSpellOnTarget(20795, Unit:GetMainTank()) 
end

function TivaxtheBreaker_Scorch(Unit, Event) 
Unit:FullCastSpellOnTarget(13878, Unit:GetMainTank()) 
end

function TivaxtheBreaker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TivaxtheBreaker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TivaxtheBreaker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26770, 1, "TivaxtheBreaker_OnCombat")
RegisterUnitEvent(26770, 2, "TivaxtheBreaker_OnLeaveCombat")
RegisterUnitEvent(26770, 3, "TivaxtheBreaker_OnKilledTarget")
RegisterUnitEvent(26770, 4, "TivaxtheBreaker_OnDied")