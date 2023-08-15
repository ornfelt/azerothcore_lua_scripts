--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Icehorn_OnCombat(Unit, Event)
Unit:RegisterEvent("Icehorn_Romp", 8000, 0)
end

function Icehorn_Romp(Unit, Event) 
Unit:CastSpell(57468) 
end

function Icehorn_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Icehorn_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Icehorn_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32361, 1, "Icehorn_OnCombat")
RegisterUnitEvent(32361, 2, "Icehorn_OnLeaveCombat")
RegisterUnitEvent(32361, 3, "Icehorn_OnKilledTarget")
RegisterUnitEvent(32361, 4, "Icehorn_OnDied")