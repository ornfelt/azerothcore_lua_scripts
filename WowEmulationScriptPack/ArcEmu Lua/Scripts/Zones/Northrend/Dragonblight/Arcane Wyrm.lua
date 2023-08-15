--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ArcaneWyrm_OnCombat(Unit, Event)
Unit:RegisterEvent("ArcaneWyrm_ArcaneInfusion", 5000, 2)
end

function ArcaneWyrm_ArcaneInfusion(Unit, Event) 
Unit:CastSpell(51732) 
end

function ArcaneWyrm_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ArcaneWyrm_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ArcaneWyrm_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26322, 1, "ArcaneWyrm_OnCombat")
RegisterUnitEvent(26322, 2, "ArcaneWyrm_OnLeaveCombat")
RegisterUnitEvent(26322, 3, "ArcaneWyrm_OnKilledTarget")
RegisterUnitEvent(26322, 4, "ArcaneWyrm_OnDied")