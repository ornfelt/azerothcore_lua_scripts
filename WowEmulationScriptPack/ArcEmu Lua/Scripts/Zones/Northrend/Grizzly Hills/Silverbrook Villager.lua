--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SilverbrookVillager_OnCombat(Unit, Event)
Unit:RegisterEvent("SilverbrookVillager_Chop", 5000, 0)
end

function SilverbrookVillager_Chop(Unit, Event) 
Unit:FullCastSpellOnTarget(43410, Unit:GetMainTank()) 
end

function SilverbrookVillager_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SilverbrookVillager_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SilverbrookVillager_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26708, 1, "SilverbrookVillager_OnCombat")
RegisterUnitEvent(26708, 2, "SilverbrookVillager_OnLeaveCombat")
RegisterUnitEvent(26708, 3, "SilverbrookVillager_OnKilledTarget")
RegisterUnitEvent(26708, 4, "SilverbrookVillager_OnDied")