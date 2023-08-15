--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function InjuredWarsongShaman_OnCombat(Unit, Event)
Unit:RegisterEvent("InjuredWarsongShaman_ChainLightning", 8000, 0)
Unit:RegisterEvent("InjuredWarsongShaman_EarthShock", 6000, 0)
end

function InjuredWarsongShaman_ChainLightning(Unit, Event) 
Unit:FullCastSpellOnTarget(16033, Unit:GetMainTank()) 
end

function InjuredWarsongShaman_EarthShock(Unit, Event) 
Unit:FullCastSpellOnTarget(25025, Unit:GetMainTank()) 
end

function InjuredWarsongShaman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InjuredWarsongShaman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InjuredWarsongShaman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27108, 1, "InjuredWarsongShaman_OnCombat")
RegisterUnitEvent(27108, 2, "InjuredWarsongShaman_OnLeaveCombat")
RegisterUnitEvent(27108, 3, "InjuredWarsongShaman_OnKilledTarget")
RegisterUnitEvent(27108, 4, "InjuredWarsongShaman_OnDied")