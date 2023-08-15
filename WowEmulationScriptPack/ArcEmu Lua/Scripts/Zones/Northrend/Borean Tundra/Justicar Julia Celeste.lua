--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function JusticarJuliaCeleste_OnCombat(Unit, Event)
Unit:RegisterEvent("JusticarJuliaCeleste_HammerofJustice", 10000, 0)
end

function JusticarJuliaCeleste_HammerofJustice(Unit, Event) 
Unit:FullCastSpellOnTarget(13005, Unit:GetMainTank()) 
end

function JusticarJuliaCeleste_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function JusticarJuliaCeleste_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function JusticarJuliaCeleste_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25264, 1, "JusticarJuliaCeleste_OnCombat")
RegisterUnitEvent(25264, 2, "JusticarJuliaCeleste_OnLeaveCombat")
RegisterUnitEvent(25264, 3, "JusticarJuliaCeleste_OnKilledTarget")
RegisterUnitEvent(25264, 4, "JusticarJuliaCeleste_OnDied")