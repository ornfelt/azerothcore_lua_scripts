--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DrakkariShaman_OnCombat(Unit, Event)
Unit:RegisterEvent("DrakkariShaman_LightningBolt", 7000, 0)
Unit:RegisterEvent("DrakkariShaman_MasteredElements", 10000, 0)
end

function DrakkariShaman_LightningBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(9532, Unit:GetMainTank()) 
end

function DrakkariShaman_MasteredElements(Unit, Event) 
Unit:CastSpell(52290) 
end

function DrakkariShaman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DrakkariShaman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DrakkariShaman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26447, 1, "DrakkariShaman_OnCombat")
RegisterUnitEvent(26447, 2, "DrakkariShaman_OnLeaveCombat")
RegisterUnitEvent(26447, 3, "DrakkariShaman_OnKilledTarget")
RegisterUnitEvent(26447, 4, "DrakkariShaman_OnDied")