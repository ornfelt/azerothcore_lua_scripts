--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function IceSerpent_OnCombat(Unit, Event)
Unit:RegisterEvent("IceSerpent_IceSlash", 7000, 0)
end

function IceSerpent_IceSlash(Unit, Event) 
Unit:FullCastSpellOnTarget(51878, Unit:GetMainTank()) 
end

function IceSerpent_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IceSerpent_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IceSerpent_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26446, 1, "IceSerpent_OnCombat")
RegisterUnitEvent(26446, 2, "IceSerpent_OnLeaveCombat")
RegisterUnitEvent(26446, 3, "IceSerpent_OnKilledTarget")
RegisterUnitEvent(26446, 4, "IceSerpent_OnDied")