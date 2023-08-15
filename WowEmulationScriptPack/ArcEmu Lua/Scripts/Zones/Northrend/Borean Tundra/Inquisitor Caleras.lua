--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function InquisitorCaleras_OnCombat(Unit, Event)
Unit:RegisterEvent("InquisitorCaleras_FrostNova", 10000, 0)
Unit:RegisterEvent("InquisitorCaleras_Frostbolt", 8000, 0)
end

function InquisitorCaleras_FrostNova(Unit, Event) 
Unit:CastSpell(32192) 
end

function InquisitorCaleras_Frostbolt(Unit, Event) 
Unit:FullCastSpellOnTarget(15043, Unit:GetMainTank()) 
end

function InquisitorCaleras_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InquisitorCaleras_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InquisitorCaleras_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25720, 1, "InquisitorCaleras_OnCombat")
RegisterUnitEvent(25720, 2, "InquisitorCaleras_OnLeaveCombat")
RegisterUnitEvent(25720, 3, "InquisitorCaleras_OnKilledTarget")
RegisterUnitEvent(25720, 4, "InquisitorCaleras_OnDied")