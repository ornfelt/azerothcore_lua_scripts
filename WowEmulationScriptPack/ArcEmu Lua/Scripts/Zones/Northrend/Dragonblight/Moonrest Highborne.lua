--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MoonrestHighborne_OnCombat(Unit, Event)
Unit:RegisterEvent("MoonrestHighborne_ShadowWordDeath", 6000, 0)
end

function MoonrestHighborne_ShadowWordDeath(Unit, Event) 
Unit:FullCastSpellOnTarget(51818, Unit:GetMainTank()) 
end

function MoonrestHighborne_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MoonrestHighborne_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MoonrestHighborne_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26455, 1, "MoonrestHighborne_OnCombat")
RegisterUnitEvent(26455, 2, "MoonrestHighborne_OnLeaveCombat")
RegisterUnitEvent(26455, 3, "MoonrestHighborne_OnKilledTarget")
RegisterUnitEvent(26455, 4, "MoonrestHighborne_OnDied")