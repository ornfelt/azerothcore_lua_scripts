--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function UnboundAncient_OnCombat(Unit, Event)
Unit:RegisterEvent("UnboundAncient_EntanglingRoots", 10000, 0)
Unit:RegisterEvent("UnboundAncient_Trample", 6000, 0)
end

function UnboundAncient_EntanglingRoots(Unit, Event) 
Unit:FullCastSpellOnTarget(33844, Unit:GetMainTank()) 
end

function UnboundAncient_Trample(Unit, Event) 
Unit:CastSpell(51944) 
end

function UnboundAncient_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function UnboundAncient_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function UnboundAncient_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30861, 1, "UnboundAncient_OnCombat")
RegisterUnitEvent(30861, 2, "UnboundAncient_OnLeaveCombat")
RegisterUnitEvent(30861, 3, "UnboundAncient_OnKilledTarget")
RegisterUnitEvent(30861, 4, "UnboundAncient_OnDied")