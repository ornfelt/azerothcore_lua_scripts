--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WindfurySorceress_OnCombat(Unit, Event)
Unit:RegisterEvent("WindfurySorceress_Frostbolt", 8000, 0)
end

function WindfurySorceress_Frostbolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(13322, pUnit:GetMainTank()) 
end

function WindfurySorceress_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WindfurySorceress_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WindfurySorceress_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2964, 1, "WindfurySorceress_OnCombat")
RegisterUnitEvent(2964, 2, "WindfurySorceress_OnLeaveCombat")
RegisterUnitEvent(2964, 3, "WindfurySorceress_OnKilledTarget")
RegisterUnitEvent(2964, 4, "WindfurySorceress_OnDied")