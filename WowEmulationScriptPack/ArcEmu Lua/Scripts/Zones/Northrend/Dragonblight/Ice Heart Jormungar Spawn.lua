--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function IceHeartJormungarSpawn_OnCombat(Unit, Event)
Unit:RegisterEvent("IceHeartJormungarSpawn_GutRip", 5000, 3)
end

function IceHeartJormungarSpawn_GutRip(Unit, Event) 
Unit:FullCastSpellOnTarget(43358, Unit:GetMainTank()) 
end

function IceHeartJormungarSpawn_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IceHeartJormungarSpawn_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IceHeartJormungarSpawn_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26359, 1, "IceHeartJormungarSpawn_OnCombat")
RegisterUnitEvent(26359, 2, "IceHeartJormungarSpawn_OnLeaveCombat")
RegisterUnitEvent(26359, 3, "IceHeartJormungarSpawn_OnKilledTarget")
RegisterUnitEvent(26359, 4, "IceHeartJormungarSpawn_OnDied")