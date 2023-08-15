--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Tatjana_OnCombat(Unit, Event)
Unit:RegisterEvent("Tatjana_Cutdown", 8000, 0)
end

function Tatjana_Cutdown(Unit, Event) 
Unit:FullCastSpellOnTarget(32009, Unit:GetMainTank()) 
end

function Tatjana_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Tatjana_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Tatjana_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27627, 1, "Tatjana_OnCombat")
RegisterUnitEvent(27627, 2, "Tatjana_OnLeaveCombat")
RegisterUnitEvent(27627, 3, "Tatjana_OnKilledTarget")
RegisterUnitEvent(27627, 4, "Tatjana_OnDied")