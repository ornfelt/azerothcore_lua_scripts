--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function TundraWolf_OnCombat(Unit, Event)
Unit:RegisterEvent("TundraWolf_InfectedBite", 8000, 0)
end

function TundraWolf_InfectedBite(Unit, Event) 
Unit:FullCastSpellOnTarget(7367, Unit:GetMainTank()) 
end

function TundraWolf_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TundraWolf_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TundraWolf_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25675, 1, "TundraWolf_OnCombat")
RegisterUnitEvent(25675, 2, "TundraWolf_OnLeaveCombat")
RegisterUnitEvent(25675, 3, "TundraWolf_OnKilledTarget")
RegisterUnitEvent(25675, 4, "TundraWolf_OnDied")