--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ColdarraSpellbinder_OnCombat(Unit, Event)
Unit:RegisterEvent("ColdarraSpellbinder_Frostbolt", 8000, 0)
end

function ColdarraSpellbinder_Frostbolt(Unit, Event) 
Unit:FullCastSpellOnTarget(9672, Unit:GetMainTank()) 
end

function ColdarraSpellbinder_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ColdarraSpellbinder_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ColdarraSpellbinder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25719, 1, "ColdarraSpellbinder_OnCombat")
RegisterUnitEvent(25719, 2, "ColdarraSpellbinder_OnLeaveCombat")
RegisterUnitEvent(25719, 3, "ColdarraSpellbinder_OnKilledTarget")
RegisterUnitEvent(25719, 4, "ColdarraSpellbinder_OnDied")