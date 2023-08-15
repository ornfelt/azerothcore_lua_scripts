--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GlimmerBayOrca_OnCombat(Unit, Event)
Unit:RegisterEvent("GlimmerBayOrca_FlipperThwack", 8000, 0)
end

function GlimmerBayOrca_FlipperThwack(Unit, Event) 
Unit:FullCastSpellOnTarget(50169, Unit:GetMainTank()) 
end

function GlimmerBayOrca_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GlimmerBayOrca_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GlimmerBayOrca_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25204, 1, "GlimmerBayOrca_OnCombat")
RegisterUnitEvent(25204, 2, "GlimmerBayOrca_OnLeaveCombat")
RegisterUnitEvent(25204, 3, "GlimmerBayOrca_OnKilledTarget")
RegisterUnitEvent(25204, 4, "GlimmerBayOrca_OnDied")