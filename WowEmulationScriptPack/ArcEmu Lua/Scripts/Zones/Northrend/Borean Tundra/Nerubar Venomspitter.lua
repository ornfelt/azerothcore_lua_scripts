--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function NerubarVenomspitter_OnCombat(Unit, Event)
Unit:RegisterEvent("NerubarVenomspitter_VenomSpit", 8000, 0)
end

function NerubarVenomspitter_VenomSpit(Unit, Event) 
Unit:FullCastSpellOnTarget(45577, Unit:GetMainTank()) 
end

function NerubarVenomspitter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NerubarVenomspitter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NerubarVenomspitter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24563, 1, "NerubarVenomspitter_OnCombat")
RegisterUnitEvent(24563, 2, "NerubarVenomspitter_OnLeaveCombat")
RegisterUnitEvent(24563, 3, "NerubarVenomspitter_OnKilledTarget")
RegisterUnitEvent(24563, 4, "NerubarVenomspitter_OnDied")