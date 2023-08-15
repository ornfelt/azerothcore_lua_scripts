--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HeigarrtheHorrible_OnCombat(Unit, Event)
Unit:RegisterEvent("HeigarrtheHorrible_Cleave", 7000, 0)
Unit:RegisterEvent("HeigarrtheHorrible_ConcussionBlow", 9000, 0)
end

function HeigarrtheHorrible_Cleave(Unit, Event) 
Unit:CastSpell(40504) 
end

function HeigarrtheHorrible_ConcussionBlow(Unit, Event) 
Unit:FullCastSpellOnTarget(32588, Unit:GetMainTank()) 
end

function HeigarrtheHorrible_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function HeigarrtheHorrible_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function HeigarrtheHorrible_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26266, 1, "HeigarrtheHorrible_OnCombat")
RegisterUnitEvent(26266, 2, "HeigarrtheHorrible_OnLeaveCombat")
RegisterUnitEvent(26266, 3, "HeigarrtheHorrible_OnKilledTarget")
RegisterUnitEvent(26266, 4, "HeigarrtheHorrible_OnDied")