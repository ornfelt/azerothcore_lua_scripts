--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SnowTrackerHaloke_OnCombat(Unit, Event)
Unit:RegisterEvent("SnowTrackerHaloke_Shoot", 6000, 0)
end

function SnowTrackerHaloke_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(6660, Unit:GetMainTank()) 
end

function SnowTrackerHaloke_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SnowTrackerHaloke_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SnowTrackerHaloke_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26768, 1, "SnowTrackerHaloke_OnCombat")
RegisterUnitEvent(26768, 2, "SnowTrackerHaloke_OnLeaveCombat")
RegisterUnitEvent(26768, 3, "SnowTrackerHaloke_OnKilledTarget")
RegisterUnitEvent(26768, 4, "SnowTrackerHaloke_OnDied")