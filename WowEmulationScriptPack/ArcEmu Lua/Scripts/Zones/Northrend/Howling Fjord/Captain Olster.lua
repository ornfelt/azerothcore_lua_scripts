--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CaptainOlster_OnCombat(Unit, Event)
Unit:RegisterEvent("CaptainOlster_ConcussionBlow", 12000, 0)
Unit:RegisterEvent("CaptainOlster_Intercept", 9000, 0)
Unit:RegisterEvent("CaptainOlster_MortalStrike", 7000, 0)
end

function CaptainOlster_ConcussionBlow(Unit, Event) 
Unit:FullCastSpellOnTarget(32588, Unit:GetMainTank()) 
end

function CaptainOlster_Intercept(Unit, Event) 
Unit:FullCastSpellOnTarget(27577, Unit:GetMainTank()) 
end

function CaptainOlster_MortalStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(16856, Unit:GetMainTank()) 
end

function CaptainOlster_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CaptainOlster_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CaptainOlster_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(23962, 1, "CaptainOlster_OnCombat")
RegisterUnitEvent(23962, 2, "CaptainOlster_OnLeaveCombat")
RegisterUnitEvent(23962, 3, "CaptainOlster_OnKilledTarget")
RegisterUnitEvent(23962, 4, "CaptainOlster_OnDied")