--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CultPlaguebringer_OnCombat(Unit, Event)
Unit:RegisterEvent("CultPlaguebringer_InjectPlague", 8000, 0)
end

function CultPlaguebringer_InjectPlague(Unit, Event) 
Unit:FullCastSpellOnTarget(50356, Unit:GetMainTank()) 
end

function CultPlaguebringer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CultPlaguebringer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CultPlaguebringer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24957, 1, "CultPlaguebringer_OnCombat")
RegisterUnitEvent(24957, 2, "CultPlaguebringer_OnLeaveCombat")
RegisterUnitEvent(24957, 3, "CultPlaguebringer_OnKilledTarget")
RegisterUnitEvent(24957, 4, "CultPlaguebringer_OnDied")