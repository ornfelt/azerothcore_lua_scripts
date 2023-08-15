--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function OnslaughtRavenArchon_OnCombat(Unit, Event)
Unit:RegisterEvent("OnslaughtRavenArchon_RavenFlock", 7000, 0)
Unit:RegisterEvent("OnslaughtRavenArchon_UnholyFrenzy", 4000, 1)
end

function OnslaughtRavenArchon_RavenFlock(Unit, Event) 
Unit:FullCastSpellOnTarget(50740, Unit:GetMainTank()) 
end

function OnslaughtRavenArchon_UnholyFrenzy(Unit, Event) 
Unit:CastSpell(50743) 
end

function OnslaughtRavenArchon_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OnslaughtRavenArchon_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OnslaughtRavenArchon_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27357, 1, "OnslaughtRavenArchon_OnCombat")
RegisterUnitEvent(27357, 2, "OnslaughtRavenArchon_OnLeaveCombat")
RegisterUnitEvent(27357, 3, "OnslaughtRavenArchon_OnKilledTarget")
RegisterUnitEvent(27357, 4, "OnslaughtRavenArchon_OnDied")