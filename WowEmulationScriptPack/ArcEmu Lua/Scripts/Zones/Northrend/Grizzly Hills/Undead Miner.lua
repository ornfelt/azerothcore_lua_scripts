--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function UndeadMiner_OnCombat(Unit, Event)
Unit:RegisterEvent("UndeadMiner_PunctureWound", 7000, 0)
Unit:RegisterEvent("UndeadMiner_ThrowLantern", 9000, 1)
end

function UndeadMiner_PunctureWound(Unit, Event) 
Unit:FullCastSpellOnTarget(48374, Unit:GetMainTank()) 
end

function UndeadMiner_ThrowLantern(Unit, Event) 
Unit:FullCastSpellOnTarget(52608, Unit:GetMainTank()) 
end

function UndeadMiner_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function UndeadMiner_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function UndeadMiner_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26891, 1, "UndeadMiner_OnCombat")
RegisterUnitEvent(26891, 2, "UndeadMiner_OnLeaveCombat")
RegisterUnitEvent(26891, 3, "UndeadMiner_OnKilledTarget")
RegisterUnitEvent(26891, 4, "UndeadMiner_OnDied")