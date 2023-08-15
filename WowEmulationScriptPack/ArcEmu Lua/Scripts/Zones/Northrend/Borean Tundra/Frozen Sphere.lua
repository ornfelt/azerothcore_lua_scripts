--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function FrozenSphere_OnCombat(Unit, Event)
Unit:RegisterEvent("FrozenSphere_IceShard", 6000, 0)
end

function FrozenSphere_IceShard(Unit, Event) 
Unit:FullCastSpellOnTarget(50578, Unit:GetMainTank()) 
end

function FrozenSphere_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FrozenSphere_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FrozenSphere_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(28066, 1, "FrozenSphere_OnCombat")
RegisterUnitEvent(28066, 2, "FrozenSphere_OnLeaveCombat")
RegisterUnitEvent(28066, 3, "FrozenSphere_OnKilledTarget")
RegisterUnitEvent(28066, 4, "FrozenSphere_OnDied")