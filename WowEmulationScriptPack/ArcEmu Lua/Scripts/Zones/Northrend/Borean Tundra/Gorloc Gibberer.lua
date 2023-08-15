--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GorlocGibberer_OnCombat(Unit, Event)
Unit:RegisterEvent("GorlocGibberer_DeepDredge", 6000, 0)
Unit:RegisterEvent("GorlocGibberer_Whirlwind", 9000, 0)
end

function GorlocGibberer_DeepDredge(Unit, Event) 
Unit:CastSpell(50520) 
end

function GorlocGibberer_Whirlwind(Unit, Event) 
Unit:CastSpell(15576) 
end

function GorlocGibberer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GorlocGibberer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GorlocGibberer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25686, 1, "GorlocGibberer_OnCombat")
RegisterUnitEvent(25686, 2, "GorlocGibberer_OnLeaveCombat")
RegisterUnitEvent(25686, 3, "GorlocGibberer_OnKilledTarget")
RegisterUnitEvent(25686, 4, "GorlocGibberer_OnDied")