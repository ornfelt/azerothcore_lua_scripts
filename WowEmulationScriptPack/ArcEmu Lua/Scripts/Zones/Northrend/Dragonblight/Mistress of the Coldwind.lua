--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MistressoftheColdwind_OnCombat(Unit, Event)
Unit:RegisterEvent("MistressoftheColdwind_ArcticWinds", 6500, 0)
Unit:RegisterEvent("MistressoftheColdwind_Renew", 18000, 0)
end

function MistressoftheColdwind_ArcticWinds(Unit, Event) 
Unit:FullCastSpellOnTarget(52814, Unit:GetMainTank()) 
end

function MistressoftheColdwind_Renew(Unit, Event) 
Unit:CastSpell(38210) 
end

function MistressoftheColdwind_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MistressoftheColdwind_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MistressoftheColdwind_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26578, 1, "MistressoftheColdwind_OnCombat")
RegisterUnitEvent(26578, 2, "MistressoftheColdwind_OnLeaveCombat")
RegisterUnitEvent(26578, 3, "MistressoftheColdwind_OnKilledTarget")
RegisterUnitEvent(26578, 4, "MistressoftheColdwind_OnDied")