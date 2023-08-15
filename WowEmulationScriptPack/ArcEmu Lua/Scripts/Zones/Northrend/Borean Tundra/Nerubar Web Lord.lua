--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function NerubarWebLord_OnCombat(Unit, Event)
Unit:RegisterEvent("NerubarWebLord_BlindingSwarm", 8000, 0)
end

function NerubarWebLord_BlindingSwarm(Unit, Event) 
Unit:FullCastSpellOnTarget(50284, Unit:GetMainTank()) 
end

function NerubarWebLord_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NerubarWebLord_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NerubarWebLord_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25294, 1, "NerubarWebLord_OnCombat")
RegisterUnitEvent(25294, 2, "NerubarWebLord_OnLeaveCombat")
RegisterUnitEvent(25294, 3, "NerubarWebLord_OnKilledTarget")
RegisterUnitEvent(25294, 4, "NerubarWebLord_OnDied")