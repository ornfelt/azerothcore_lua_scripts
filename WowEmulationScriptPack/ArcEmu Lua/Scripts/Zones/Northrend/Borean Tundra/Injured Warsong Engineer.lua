--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function InjuredWarsongEngineer_OnCombat(Unit, Event)
Unit:RegisterEvent("InjuredWarsongEngineer_GoblinDragonGun", 8000, 0)
Unit:RegisterEvent("InjuredWarsongEngineer_SuperShrinkRay", 10000, 0)
end

function InjuredWarsongEngineer_GoblinDragonGun(Unit, Event) 
Unit:CastSpell(44273) 
end

function InjuredWarsongEngineer_SuperShrinkRay(Unit, Event) 
Unit:CastSpell(22742) 
end

function InjuredWarsongEngineer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InjuredWarsongEngineer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InjuredWarsongEngineer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27110, 1, "InjuredWarsongEngineer_OnCombat")
RegisterUnitEvent(27110, 2, "InjuredWarsongEngineer_OnLeaveCombat")
RegisterUnitEvent(27110, 3, "InjuredWarsongEngineer_OnKilledTarget")
RegisterUnitEvent(27110, 4, "InjuredWarsongEngineer_OnDied")