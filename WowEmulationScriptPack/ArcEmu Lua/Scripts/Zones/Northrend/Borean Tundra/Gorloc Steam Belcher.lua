--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GorlocSteamBelcher_OnCombat(Unit, Event)
Unit:RegisterEvent("GorlocSteamBelcher_BelchBlast", 7000, 0)
end

function GorlocSteamBelcher_BelchBlast(Unit, Event) 
Unit:FullCastSpellOnTarget(50538, Unit:GetMainTank()) 
end

function GorlocSteamBelcher_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GorlocSteamBelcher_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GorlocSteamBelcher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25687, 1, "GorlocSteamBelcher_OnCombat")
RegisterUnitEvent(25687, 2, "GorlocSteamBelcher_OnLeaveCombat")
RegisterUnitEvent(25687, 3, "GorlocSteamBelcher_OnKilledTarget")
RegisterUnitEvent(25687, 4, "GorlocSteamBelcher_OnDied")