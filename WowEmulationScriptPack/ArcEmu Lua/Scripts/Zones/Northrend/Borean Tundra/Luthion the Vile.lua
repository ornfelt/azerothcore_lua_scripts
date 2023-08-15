--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function LuthiontheVile_OnCombat(Unit, Event)
Unit:RegisterEvent("LuthiontheVile_BloodPresence", 4000, 1)
Unit:RegisterEvent("LuthiontheVile_PlagueStrike", 9000, 0)
end

function LuthiontheVile_BloodPresence(Unit, Event) 
Unit:CastSpell(50689) 
end

function LuthiontheVile_PlagueStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(50688, Unit:GetMainTank()) 
end

function LuthiontheVile_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function LuthiontheVile_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function LuthiontheVile_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27860, 1, "LuthiontheVile_OnCombat")
RegisterUnitEvent(27860, 2, "LuthiontheVile_OnLeaveCombat")
RegisterUnitEvent(27860, 3, "LuthiontheVile_OnKilledTarget")
RegisterUnitEvent(27860, 4, "LuthiontheVile_OnDied")