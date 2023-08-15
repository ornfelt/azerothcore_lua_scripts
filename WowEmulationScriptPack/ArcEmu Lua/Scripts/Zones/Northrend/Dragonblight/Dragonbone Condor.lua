--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DragonboneCondor_OnCombat(Unit, Event)
Unit:RegisterEvent("DragonboneCondor_EvasiveManeuver", 6000, 0)
end

function DragonboneCondor_EvasiveManeuver(Unit, Event) 
Unit:CastSpell(51946) 
end

function DragonboneCondor_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DragonboneCondor_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DragonboneCondor_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26483, 1, "DragonboneCondor_OnCombat")
RegisterUnitEvent(26483, 2, "DragonboneCondor_OnLeaveCombat")
RegisterUnitEvent(26483, 3, "DragonboneCondor_OnKilledTarget")
RegisterUnitEvent(26483, 4, "DragonboneCondor_OnDied")