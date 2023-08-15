--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Iceshatter_OnCombat(Unit, Event)
Unit:RegisterEvent("Iceshatter_MagnataurCharge", 8000, 0)
Unit:RegisterEvent("Iceshatter_PulsingShards", 6000, 0)
end

function Iceshatter_MagnataurCharge(Unit, Event) 
Unit:FullCastSpellOnTarget(52088, Unit:GetMainTank()) 
end

function Iceshatter_PulsingShards(Unit, Event) 
Unit:CastSpell(52118) 
end

function Iceshatter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Iceshatter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Iceshatter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27007, 1, "Iceshatter_OnCombat")
RegisterUnitEvent(27007, 2, "Iceshatter_OnLeaveCombat")
RegisterUnitEvent(27007, 3, "Iceshatter_OnKilledTarget")
RegisterUnitEvent(27007, 4, "Iceshatter_OnDied")