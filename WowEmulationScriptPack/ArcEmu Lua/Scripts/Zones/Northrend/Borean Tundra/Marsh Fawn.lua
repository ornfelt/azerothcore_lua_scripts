--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function MarshFawn_OnCombat(Unit, Event)
Unit:RegisterEvent("MarshFawn_Gore", 8000, 0)
end

function MarshFawn_Gore(Unit, Event) 
Unit:FullCastSpellOnTarget(32019, Unit:GetMainTank()) 
end

function MarshFawn_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MarshFawn_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MarshFawn_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25829, 1, "MarshFawn_OnCombat")
RegisterUnitEvent(25829, 2, "MarshFawn_OnLeaveCombat")
RegisterUnitEvent(25829, 3, "MarshFawn_OnKilledTarget")
RegisterUnitEvent(25829, 4, "MarshFawn_OnDied")