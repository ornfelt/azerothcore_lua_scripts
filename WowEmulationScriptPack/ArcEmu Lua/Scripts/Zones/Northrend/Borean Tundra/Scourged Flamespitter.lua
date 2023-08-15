--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ScourgedFlamespitter_OnCombat(Unit, Event)
Unit:RegisterEvent("ScourgedFlamespitter_Incinerate", 7000, 0)
end

function ScourgedFlamespitter_Incinerate(Unit, Event) 
Unit:FullCastSpellOnTarget(32707, Unit:GetMainTank()) 
end

function ScourgedFlamespitter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ScourgedFlamespitter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ScourgedFlamespitter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25582, 1, "ScourgedFlamespitter_OnCombat")
RegisterUnitEvent(25582, 2, "ScourgedFlamespitter_OnLeaveCombat")
RegisterUnitEvent(25582, 3, "ScourgedFlamespitter_OnKilledTarget")
RegisterUnitEvent(25582, 4, "ScourgedFlamespitter_OnDied")