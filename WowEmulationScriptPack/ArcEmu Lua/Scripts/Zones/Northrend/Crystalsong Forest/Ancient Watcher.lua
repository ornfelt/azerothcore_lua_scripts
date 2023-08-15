--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function AncientWatcher_OnCombat(Unit, Event)
Unit:RegisterEvent("AncientWatcher_EntanglingRoots", 10000, 0)
Unit:RegisterEvent("AncientWatcher_Trample", 6000, 0)
end

function AncientWatcher_EntanglingRoots(Unit, Event) 
Unit:FullCastSpellOnTarget(33844, Unit:GetMainTank()) 
end

function AncientWatcher_Trample(Unit, Event) 
Unit:CastSpell(51944) 
end

function AncientWatcher_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AncientWatcher_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AncientWatcher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(31229, 1, "AncientWatcher_OnCombat")
RegisterUnitEvent(31229, 2, "AncientWatcher_OnLeaveCombat")
RegisterUnitEvent(31229, 3, "AncientWatcher_OnKilledTarget")
RegisterUnitEvent(31229, 4, "AncientWatcher_OnDied")