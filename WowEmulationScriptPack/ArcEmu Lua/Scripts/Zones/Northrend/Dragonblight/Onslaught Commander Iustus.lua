--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function OnslaughtCommanderIustus_OnCombat(Unit, Event)
Unit:RegisterEvent("OnslaughtCommanderIustus_Bloodthirst", 6000, 0)
Unit:RegisterEvent("OnslaughtCommanderIustus_Whirlwind", 7000, 0)
end

function OnslaughtCommanderIustus_Bloodthirst(Unit, Event) 
Unit:FullCastSpellOnTarget(35949, Unit:GetMainTank()) 
end

function OnslaughtCommanderIustus_Whirlwind(Unit, Event) 
Unit:CastSpell(48281) 
end

function OnslaughtCommanderIustus_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OnslaughtCommanderIustus_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OnslaughtCommanderIustus_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27334, 1, "OnslaughtCommanderIustus_OnCombat")
RegisterUnitEvent(27334, 2, "OnslaughtCommanderIustus_OnLeaveCombat")
RegisterUnitEvent(27334, 3, "OnslaughtCommanderIustus_OnKilledTarget")
RegisterUnitEvent(27334, 4, "OnslaughtCommanderIustus_OnDied")