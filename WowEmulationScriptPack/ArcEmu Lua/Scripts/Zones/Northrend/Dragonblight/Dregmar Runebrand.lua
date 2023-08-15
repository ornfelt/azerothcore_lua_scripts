--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DregmarRunebrand_OnCombat(Unit, Event)
Unit:RegisterEvent("DregmarRunebrand_RuneShield", 20000, 1)
end

function DregmarRunebrand_RuneShield(Unit, Event) 
Unit:CastSpell(48325) 
end

function DregmarRunebrand_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DregmarRunebrand_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DregmarRunebrand_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27003, 1, "DregmarRunebrand_OnCombat")
RegisterUnitEvent(27003, 2, "DregmarRunebrand_OnLeaveCombat")
RegisterUnitEvent(27003, 3, "DregmarRunebrand_OnKilledTarget")
RegisterUnitEvent(27003, 4, "DregmarRunebrand_OnDied")