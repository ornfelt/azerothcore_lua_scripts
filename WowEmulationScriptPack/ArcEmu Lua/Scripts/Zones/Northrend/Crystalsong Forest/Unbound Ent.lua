--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function UnboundEnt_OnCombat(Unit, Event)
Unit:RegisterEvent("UnboundEnt_CorruptedRejuvenation", 8000, 0)
Unit:RegisterEvent("UnboundEnt_Thorns", 2000, 1)
end

function UnboundEnt_CorruptedRejuvenation(Unit, Event) 
Unit:FullCastSpellOnTarget(58624, Unit:GetMainTank()) 
end

function UnboundEnt_Thorns(Unit, Event) 
Unit:CastSpell(35361) 
end

function UnboundEnt_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function UnboundEnt_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function UnboundEnt_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30862, 1, "UnboundEnt_OnCombat")
RegisterUnitEvent(30862, 2, "UnboundEnt_OnLeaveCombat")
RegisterUnitEvent(30862, 3, "UnboundEnt_OnKilledTarget")
RegisterUnitEvent(30862, 4, "UnboundEnt_OnDied")