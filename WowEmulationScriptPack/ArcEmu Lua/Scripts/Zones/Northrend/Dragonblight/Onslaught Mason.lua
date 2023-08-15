--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function OnslaughtMason_OnCombat(Unit, Event)
Unit:RegisterEvent("OnslaughtMason_SlingMortar", 6500, 0)
Unit:RegisterEvent("OnslaughtMason_SunderArmor", 5500, 0)
end

function OnslaughtMason_SlingMortar(Unit, Event) 
Unit:FullCastSpellOnTarget(50701, Unit:GetMainTank()) 
end

function OnslaughtMason_SunderArmor(Unit, Event) 
Unit:FullCastSpellOnTarget(50370, Unit:GetMainTank()) 
end

function OnslaughtMason_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OnslaughtMason_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OnslaughtMason_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27333, 1, "OnslaughtMason_OnCombat")
RegisterUnitEvent(27333, 2, "OnslaughtMason_OnLeaveCombat")
RegisterUnitEvent(27333, 3, "OnslaughtMason_OnKilledTarget")
RegisterUnitEvent(27333, 4, "OnslaughtMason_OnDied")