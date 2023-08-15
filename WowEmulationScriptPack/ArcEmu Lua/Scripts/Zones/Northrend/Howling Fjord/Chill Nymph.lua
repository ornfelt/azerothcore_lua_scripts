--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ChillNymph_OnCombat(Unit, Event)
Unit:RegisterEvent("ChillNymph_SummonScarletBud", 1000, 1)
Unit:RegisterEvent("ChillNymph_Wrath", 6000, 0)
end

function ChillNymph_SummonScarletBud(Unit, Event) 
Unit:CastSpell(42388) 
end

function ChillNymph_Wrath(Unit, Event) 
Unit:FullCastSpellOnTarget(9739, Unit:GetMainTank()) 
end

function ChillNymph_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ChillNymph_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ChillNymph_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(23678, 1, "ChillNymph_OnCombat")
RegisterUnitEvent(23678, 2, "ChillNymph_OnLeaveCombat")
RegisterUnitEvent(23678, 3, "ChillNymph_OnKilledTarget")
RegisterUnitEvent(23678, 4, "ChillNymph_OnDied")