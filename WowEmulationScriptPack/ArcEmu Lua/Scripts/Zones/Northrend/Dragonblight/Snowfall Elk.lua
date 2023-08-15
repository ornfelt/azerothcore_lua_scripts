--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SnowfallElk_OnCombat(Unit, Event)
Unit:RegisterEvent("SnowfallElk_Puncture", 5000, 0)
end

function SnowfallElk_Puncture(Unit, Event) 
Unit:FullCastSpellOnTarget(15976, Unit:GetMainTank()) 
end

function SnowfallElk_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SnowfallElk_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SnowfallElk_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26615, 1, "SnowfallElk_OnCombat")
RegisterUnitEvent(26615, 2, "SnowfallElk_OnLeaveCombat")
RegisterUnitEvent(26615, 3, "SnowfallElk_OnKilledTarget")
RegisterUnitEvent(26615, 4, "SnowfallElk_OnDied")