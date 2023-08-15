--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function LootCrazedDiver_OnCombat(Unit, Event)
Unit:RegisterEvent("LootCrazedDiver_Crazed", 5000, 1)
end

function LootCrazedDiver_Crazed(Unit, Event) 
Unit:CastSpell(5915) 
end

function LootCrazedDiver_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function LootCrazedDiver_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function LootCrazedDiver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25836, 1, "LootCrazedDiver_OnCombat")
RegisterUnitEvent(25836, 2, "LootCrazedDiver_OnLeaveCombat")
RegisterUnitEvent(25836, 3, "LootCrazedDiver_OnKilledTarget")
RegisterUnitEvent(25836, 4, "LootCrazedDiver_OnDied")