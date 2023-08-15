--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DreadboneInvader_OnCombat(Unit, Event)
Unit:RegisterEvent("DreadboneInvader_Soulthirst", 10000, 0)
end

function DreadboneInvader_Soulthirst(Unit, Event) 
Unit:FullCastSpellOnTarget(51290, Unit:GetMainTank()) 
end

function DreadboneInvader_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DreadboneInvader_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DreadboneInvader_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27286, 1, "DreadboneInvader_OnCombat")
RegisterUnitEvent(27286, 2, "DreadboneInvader_OnLeaveCombat")
RegisterUnitEvent(27286, 3, "DreadboneInvader_OnKilledTarget")
RegisterUnitEvent(27286, 4, "DreadboneInvader_OnDied")