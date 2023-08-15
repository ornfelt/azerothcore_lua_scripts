--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function InjuredWarsongMage_OnCombat(Unit, Event)
Unit:RegisterEvent("InjuredWarsongMage_ArcaneExplosion", 6000, 0)
Unit:RegisterEvent("InjuredWarsongMage_Blizzard", 10000, 0)
Unit:RegisterEvent("InjuredWarsongMage_Pyroblast", 11000, 0)
end

function InjuredWarsongMage_ArcaneExplosion(Unit, Event) 
Unit:CastSpell(34933) 
end

function InjuredWarsongMage_Blizzard(Unit, Event) 
Unit:CastSpell(46195) 
end

function InjuredWarsongMage_Pyroblast(Unit, Event) 
Unit:FullCastSpellOnTarget(17274, Unit:GetMainTank()) 
end

function InjuredWarsongMage_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InjuredWarsongMage_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InjuredWarsongMage_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27107, 1, "InjuredWarsongMage_OnCombat")
RegisterUnitEvent(27107, 2, "InjuredWarsongMage_OnLeaveCombat")
RegisterUnitEvent(27107, 3, "InjuredWarsongMage_OnKilledTarget")
RegisterUnitEvent(27107, 4, "InjuredWarsongMage_OnDied")