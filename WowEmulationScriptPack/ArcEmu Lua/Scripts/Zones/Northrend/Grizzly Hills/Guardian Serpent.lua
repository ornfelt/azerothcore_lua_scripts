--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GuardianSerpent_OnCombat(Unit, Event)
Unit:RegisterEvent("GuardianSerpent_TailLash", 6000, 0)
end

function GuardianSerpent_TailLash(Unit, Event) 
Unit:FullCastSpellOnTarget(34811, Unit:GetMainTank()) 
end

function GuardianSerpent_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GuardianSerpent_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GuardianSerpent_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26806, 1, "GuardianSerpent_OnCombat")
RegisterUnitEvent(26806, 2, "GuardianSerpent_OnLeaveCombat")
RegisterUnitEvent(26806, 3, "GuardianSerpent_OnKilledTarget")
RegisterUnitEvent(26806, 4, "GuardianSerpent_OnDied")