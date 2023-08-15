--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function FordragonGryphonRider_OnCombat(Unit, Event)
Unit:RegisterEvent("FordragonGryphonRider_Stormhammer", 9000, 0)
end

function FordragonGryphonRider_Stormhammer(Unit, Event) 
Unit:FullCastSpellOnTarget(49482, Unit:GetMainTank()) 
end

function FordragonGryphonRider_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FordragonGryphonRider_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FordragonGryphonRider_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27521, 1, "FordragonGryphonRider_OnCombat")
RegisterUnitEvent(27521, 2, "FordragonGryphonRider_OnLeaveCombat")
RegisterUnitEvent(27521, 3, "FordragonGryphonRider_OnKilledTarget")
RegisterUnitEvent(27521, 4, "FordragonGryphonRider_OnDied")