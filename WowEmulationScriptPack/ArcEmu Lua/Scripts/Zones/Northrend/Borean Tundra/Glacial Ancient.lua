--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GlacialAncient_OnCombat(Unit, Event)
Unit:RegisterEvent("GlacialAncient_FrostBreath", 8000, 0)
end

function GlacialAncient_FrostBreath(Unit, Event) 
Unit:CastSpell(50505) 
end

function GlacialAncient_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GlacialAncient_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GlacialAncient_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25709, 1, "GlacialAncient_OnCombat")
RegisterUnitEvent(25709, 2, "GlacialAncient_OnLeaveCombat")
RegisterUnitEvent(25709, 3, "GlacialAncient_OnKilledTarget")
RegisterUnitEvent(25709, 4, "GlacialAncient_OnDied")