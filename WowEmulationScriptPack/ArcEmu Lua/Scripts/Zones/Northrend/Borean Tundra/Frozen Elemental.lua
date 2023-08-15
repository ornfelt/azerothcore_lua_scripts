--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function FrozenElemental_OnCombat(Unit, Event)
Unit:RegisterEvent("FrozenElemental_IceSpike", 8000, 0)
end

function FrozenElemental_IceSpike(Unit, Event) 
Unit:FullCastSpellOnTarget(50094, Unit:GetMainTank()) 
end

function FrozenElemental_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FrozenElemental_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FrozenElemental_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25715, 1, "FrozenElemental_OnCombat")
RegisterUnitEvent(25715, 2, "FrozenElemental_OnLeaveCombat")
RegisterUnitEvent(25715, 3, "FrozenElemental_OnKilledTarget")
RegisterUnitEvent(25715, 4, "FrozenElemental_OnDied")