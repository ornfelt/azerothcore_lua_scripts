--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Rattlebore_OnCombat(Unit, Event)
Unit:RegisterEvent("Rattlebore_CorrodedMind", 10000, 0)
Unit:RegisterEvent("Rattlebore_CorrosiveSpit", 9000, 0)
Unit:RegisterEvent("Rattlebore_PowerfulBite", 7000, 0)
end

function Rattlebore_CorrodedMind(Unit, Event) 
Unit:FullCastSpellOnTarget(51203, Unit:GetMainTank()) 
end

function Rattlebore_CorrosiveSpit(Unit, Event) 
Unit:FullCastSpellOnTarget(47447, Unit:GetMainTank()) 
end

function Rattlebore_PowerfulBite(Unit, Event) 
Unit:FullCastSpellOnTarget(48287, Unit:GetMainTank()) 
end

function Rattlebore_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Rattlebore_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Rattlebore_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26360, 1, "Rattlebore_OnCombat")
RegisterUnitEvent(26360, 2, "Rattlebore_OnLeaveCombat")
RegisterUnitEvent(26360, 3, "Rattlebore_OnKilledTarget")
RegisterUnitEvent(26360, 4, "Rattlebore_OnDied")