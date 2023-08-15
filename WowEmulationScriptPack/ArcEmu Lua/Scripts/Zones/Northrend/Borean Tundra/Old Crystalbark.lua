--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function OldCrystalbark_OnCombat(Unit, Event)
Unit:RegisterEvent("OldCrystalbark_ArcaneBreath", 8000, 0)
Unit:RegisterEvent("OldCrystalbark_MarkofDetonation", 6000, 0)
end

function OldCrystalbark_ArcaneBreath(Unit, Event) 
Unit:CastSpell(60903) 
end

function OldCrystalbark_MarkofDetonation(Unit, Event) 
Unit:CastSpell(50506) 
end

function OldCrystalbark_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OldCrystalbark_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OldCrystalbark_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32357, 1, "OldCrystalbark_OnCombat")
RegisterUnitEvent(32357, 2, "OldCrystalbark_OnLeaveCombat")
RegisterUnitEvent(32357, 3, "OldCrystalbark_OnKilledTarget")
RegisterUnitEvent(32357, 4, "OldCrystalbark_OnDied")