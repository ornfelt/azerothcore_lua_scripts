--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MadJonahSterling_OnCombat(Unit, Event)
Unit:RegisterEvent("MadJonahSterling_WildlyFlailing", 6000, 0)
end

function MadJonahSterling_WildlyFlailing(Unit, Event) 
Unit:FullCastSpellOnTarget(50188, Unit:GetMainTank()) 
end

function MadJonahSterling_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MadJonahSterling_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MadJonahSterling_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24742, 1, "MadJonahSterling_OnCombat")
RegisterUnitEvent(24742, 2, "MadJonahSterling_OnLeaveCombat")
RegisterUnitEvent(24742, 3, "MadJonahSterling_OnKilledTarget")
RegisterUnitEvent(24742, 4, "MadJonahSterling_OnDied")