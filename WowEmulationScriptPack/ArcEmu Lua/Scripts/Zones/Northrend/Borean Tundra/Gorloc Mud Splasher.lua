--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GorlocMudSplasher_OnCombat(Unit, Event)
Unit:RegisterEvent("GorlocMudSplasher_GorlocStomp", 6000, 0)
end

function GorlocMudSplasher_GorlocStomp(Unit, Event) 
Unit:CastSpell(50522) 
end

function GorlocMudSplasher_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GorlocMudSplasher_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GorlocMudSplasher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25699, 1, "GorlocMudSplasher_OnCombat")
RegisterUnitEvent(25699, 2, "GorlocMudSplasher_OnLeaveCombat")
RegisterUnitEvent(25699, 3, "GorlocMudSplasher_OnKilledTarget")
RegisterUnitEvent(25699, 4, "GorlocMudSplasher_OnDied")