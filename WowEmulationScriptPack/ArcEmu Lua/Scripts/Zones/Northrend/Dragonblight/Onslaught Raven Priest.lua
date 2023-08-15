--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function OnslaughtRavenPriest_OnCombat(Unit, Event)
Unit:RegisterEvent("OnslaughtRavenPriest_RavenFlock", 7000, 0)
Unit:RegisterEvent("OnslaughtRavenPriest_RavenHeal", 9000, 0)
end

function OnslaughtRavenPriest_RavenFlock(Unit, Event) 
Unit:FullCastSpellOnTarget(50740, Unit:GetClosestPlayer()) 
end

function OnslaughtRavenPriest_RavenHeal(Unit, Event) 
Unit:CastSpell(50750) 
end

function OnslaughtRavenPriest_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OnslaughtRavenPriest_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OnslaughtRavenPriest_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27202, 1, "OnslaughtRavenPriest_OnCombat")
RegisterUnitEvent(27202, 2, "OnslaughtRavenPriest_OnLeaveCombat")
RegisterUnitEvent(27202, 3, "OnslaughtRavenPriest_OnKilledTarget")
RegisterUnitEvent(27202, 4, "OnslaughtRavenPriest_OnDied")