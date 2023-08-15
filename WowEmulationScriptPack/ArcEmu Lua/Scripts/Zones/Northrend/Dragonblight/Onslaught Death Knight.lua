--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function OnslaughtDeathKnight_OnCombat(Unit, Event)
Unit:RegisterEvent("OnslaughtDeathKnight_BloodPresence", 1000, 1)
Unit:RegisterEvent("OnslaughtDeathKnight_PlagueStrike", 8000, 0)
end

function OnslaughtDeathKnight_BloodPresence(Unit, Event) 
Unit:CastSpell(50689) 
end

function OnslaughtDeathKnight_PlagueStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(50688, Unit:GetMainTank()) 
end

function OnslaughtDeathKnight_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OnslaughtDeathKnight_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OnslaughtDeathKnight_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27367, 1, "OnslaughtDeathKnight_OnCombat")
RegisterUnitEvent(27367, 2, "OnslaughtDeathKnight_OnLeaveCombat")
RegisterUnitEvent(27367, 3, "OnslaughtDeathKnight_OnKilledTarget")
RegisterUnitEvent(27367, 4, "OnslaughtDeathKnight_OnDied")