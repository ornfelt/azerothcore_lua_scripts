--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function IceshardElemental_OnCombat(Unit, Event)
Unit:RegisterEvent("IceshardElemental_IceSpike", 8000, 0)
end

function IceshardElemental_IceSpike(Unit, Event) 
Unit:FullCastSpellOnTarget(50094, Unit:GetMainTank()) 
end

function IceshardElemental_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IceshardElemental_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IceshardElemental_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24228, 1, "IceshardElemental_OnCombat")
RegisterUnitEvent(24228, 2, "IceshardElemental_OnLeaveCombat")
RegisterUnitEvent(24228, 3, "IceshardElemental_OnKilledTarget")
RegisterUnitEvent(24228, 4, "IceshardElemental_OnDied")