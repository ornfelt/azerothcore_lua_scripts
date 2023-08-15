--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function InjuredWarsongWarrior_OnCombat(Unit, Event)
Unit:RegisterEvent("InjuredWarsongWarrior_Cleave", 6000, 0)
Unit:RegisterEvent("InjuredWarsongWarrior_HeroicStrike", 7000, 0)
end

function InjuredWarsongWarrior_Cleave(Unit, Event) 
Unit:CastSpell(39047) 
end

function InjuredWarsongWarrior_HeroicStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(45026, Unit:GetMainTank()) 
end

function InjuredWarsongWarrior_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InjuredWarsongWarrior_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InjuredWarsongWarrior_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27106, 1, "InjuredWarsongWarrior_OnCombat")
RegisterUnitEvent(27106, 2, "InjuredWarsongWarrior_OnLeaveCombat")
RegisterUnitEvent(27106, 3, "InjuredWarsongWarrior_OnKilledTarget")
RegisterUnitEvent(27106, 4, "InjuredWarsongWarrior_OnDied")