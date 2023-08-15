--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function NerubarTunneler_OnCombat(Unit, Event)
Unit:RegisterEvent("NerubarTunneler_RockShield", 8000, 0)
end

function NerubarTunneler_RockShield(Unit, Event) 
Unit:CastSpell(50364) 
end

function NerubarTunneler_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NerubarTunneler_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NerubarTunneler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25622, 1, "NerubarTunneler_OnCombat")
RegisterUnitEvent(25622, 2, "NerubarTunneler_OnLeaveCombat")
RegisterUnitEvent(25622, 3, "NerubarTunneler_OnKilledTarget")
RegisterUnitEvent(25622, 4, "NerubarTunneler_OnDied")