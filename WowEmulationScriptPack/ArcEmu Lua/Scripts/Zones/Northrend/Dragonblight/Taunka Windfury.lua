--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TaunkaWindfury_OnCombat(Unit, Event)
Unit:RegisterEvent("TaunkaWindfury_HealingTouch", 10000, 0)
Unit:RegisterEvent("TaunkaWindfury_Moonfire", 5500, 0)
end

function TaunkaWindfury_HealingTouch(Unit, Event) 
Unit:CastSpell(23381) 
end

function TaunkaWindfury_Moonfire(Unit, Event) 
Unit:FullCastSpellOnTarget(23380, Unit:GetMainTank()) 
end

function TaunkaWindfury_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TaunkaWindfury_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TaunkaWindfury_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27571, 1, "TaunkaWindfury_OnCombat")
RegisterUnitEvent(27571, 2, "TaunkaWindfury_OnLeaveCombat")
RegisterUnitEvent(27571, 3, "TaunkaWindfury_OnKilledTarget")
RegisterUnitEvent(27571, 4, "TaunkaWindfury_OnDied")