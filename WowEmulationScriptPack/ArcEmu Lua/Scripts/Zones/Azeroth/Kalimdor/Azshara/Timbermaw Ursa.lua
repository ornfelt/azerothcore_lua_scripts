--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function TimbermawUrsa_OnCombat(Unit, Event)
	Unit:RegisterEvent("TimbermawUrsa_Thunderclap", 8000, 0)
end

function TimbermawUrsa_Thunderclap(pUnit, Event) 
	pUnit:CastSpell(8078) 
end

function TimbermawUrsa_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TimbermawUrsa_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6189, 1, "TimbermawUrsa_OnCombat")
RegisterUnitEvent(6189, 2, "TimbermawUrsa_OnLeaveCombat")
RegisterUnitEvent(6189, 4, "TimbermawUrsa_OnDied")