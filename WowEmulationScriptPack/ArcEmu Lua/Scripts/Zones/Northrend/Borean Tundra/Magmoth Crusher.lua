--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MagmothCrusher_OnCombat(Unit, Event)
Unit:RegisterEvent("MagmothCrusher_MagnataurCharge", 8000, 0)
Unit:RegisterEvent("MagmothCrusher_TuskStrike", 7000, 0)
end

function MagmothCrusher_MagnataurCharge(Unit, Event) 
Unit:CastSpell(50413) 
end

function MagmothCrusher_TuskStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(50410, Unit:GetMainTank()) 
end

function MagmothCrusher_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MagmothCrusher_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MagmothCrusher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25434, 1, "MagmothCrusher_OnCombat")
RegisterUnitEvent(25434, 2, "MagmothCrusher_OnLeaveCombat")
RegisterUnitEvent(25434, 3, "MagmothCrusher_OnKilledTarget")
RegisterUnitEvent(25434, 4, "MagmothCrusher_OnDied")