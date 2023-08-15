--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GarlGrimgrizzle_OnCombat(Unit, Event)
Unit:RegisterEvent("GarlGrimgrizzle_ShootGun", 6000, 0)
end

function GarlGrimgrizzle_ShootGun(Unit, Event) 
Unit:FullCastSpellOnTarget(61353, Unit:GetMainTank()) 
end

function GarlGrimgrizzle_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GarlGrimgrizzle_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GarlGrimgrizzle_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32710, 1, "GarlGrimgrizzle_OnCombat")
RegisterUnitEvent(32710, 2, "GarlGrimgrizzle_OnLeaveCombat")
RegisterUnitEvent(32710, 3, "GarlGrimgrizzle_OnKilledTarget")
RegisterUnitEvent(32710, 4, "GarlGrimgrizzle_OnDied")