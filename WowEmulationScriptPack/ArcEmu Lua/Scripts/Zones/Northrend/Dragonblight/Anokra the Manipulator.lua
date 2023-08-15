--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AnokratheManipulator_OnCombat(Unit, Event)
Unit:RegisterEvent("AnokratheManipulator_MindBlast", 6000, 0)
Unit:RegisterEvent("AnokratheManipulator_MindFlay", 8000, 0)
Unit:RegisterEvent("AnokratheManipulator_WaveringWill", 2000, 1)
end

function AnokratheManipulator_MindBlast(Unit, Event) 
Unit:FullCastSpellOnTarget(13860, Unit:GetMainTank()) 
end

function AnokratheManipulator_MindFlay(Unit, Event) 
Unit:FullCastSpellOnTarget(16568, Unit:GetMainTank()) 
end

function AnokratheManipulator_WaveringWill(Unit, Event) 
Unit:FullCastSpellOnTarget(51676, Unit:GetMainTank()) 
end

function AnokratheManipulator_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AnokratheManipulator_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AnokratheManipulator_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26769, 1, "AnokratheManipulator_OnCombat")
RegisterUnitEvent(26769, 2, "AnokratheManipulator_OnLeaveCombat")
RegisterUnitEvent(26769, 3, "AnokratheManipulator_OnKilledTarget")
RegisterUnitEvent(26769, 4, "AnokratheManipulator_OnDied")