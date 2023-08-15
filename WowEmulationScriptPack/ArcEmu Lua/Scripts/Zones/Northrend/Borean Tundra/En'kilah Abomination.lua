--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function EnkilahAbomination_OnCombat(Unit, Event)
Unit:RegisterEvent("EnkilahAbomination_Cleave", 8000, 0)
Unit:RegisterEvent("EnkilahAbomination_ScourgeHook", 6000, 0)
end

function EnkilahAbomination_Cleave(Unit, Event) 
Unit:CastSpell(40504) 
end

function EnkilahAbomination_ScourgeHook(Unit, Event) 
Unit:FullCastSpellOnTarget(50335, Unit:GetMainTank()) 
end

function EnkilahAbomination_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EnkilahAbomination_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EnkilahAbomination_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25383, 1, "EnkilahAbomination_OnCombat")
RegisterUnitEvent(25383, 2, "EnkilahAbomination_OnLeaveCombat")
RegisterUnitEvent(25383, 3, "EnkilahAbomination_OnKilledTarget")
RegisterUnitEvent(25383, 4, "EnkilahAbomination_OnDied")