--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Goramosh_OnCombat(Unit, Event)
Unit:RegisterEvent("Goramosh_ConeofCold", 6000, 0)
Unit:RegisterEvent("Goramosh_Frostbolt", 8000, 0)
end

function Goramosh_ConeofCold(Unit, Event) 
Unit:CastSpell(20828) 
end

function Goramosh_Frostbolt(Unit, Event) 
Unit:FullCastSpellOnTarget(9672, Unit:GetMainTank()) 
end

function Goramosh_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Goramosh_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Goramosh_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26349, 1, "Goramosh_OnCombat")
RegisterUnitEvent(26349, 2, "Goramosh_OnLeaveCombat")
RegisterUnitEvent(26349, 3, "Goramosh_OnKilledTarget")
RegisterUnitEvent(26349, 4, "Goramosh_OnDied")