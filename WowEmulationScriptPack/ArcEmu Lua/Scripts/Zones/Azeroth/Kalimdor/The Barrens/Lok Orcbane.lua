--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function LokOrcbane_OnCombat(Unit, Event)
	Unit:RegisterEvent("LokOrcbane_Hamstring", 8000, 0)
end

function LokOrcbane_Hamstring(Unit, Event) 
	Unit:FullCastSpellOnTarget(9080, 	Unit:GetMainTank()) 
end

function LokOrcbane_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function LokOrcbane_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function LokOrcbane_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3435, 1, "LokOrcbane_OnCombat")
RegisterUnitEvent(3435, 2, "LokOrcbane_OnLeaveCombat")
RegisterUnitEvent(3435, 3, "LokOrcbane_OnKilledTarget")
RegisterUnitEvent(3435, 4, "LokOrcbane_OnDied")