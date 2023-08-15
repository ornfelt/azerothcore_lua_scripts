--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SerenaBloodfeather_OnCombat(Unit, Event)
	Unit:RegisterEvent("SerenaBloodfeather_BloodHowl", 10000, 0)
end

function SerenaBloodfeather_BloodHowl(Unit, Event) 
	Unit:FullCastSpellOnTarget(3264, 	Unit:GetMainTank()) 
end

function SerenaBloodfeather_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SerenaBloodfeather_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function SerenaBloodfeather_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3452, 1, "SerenaBloodfeather_OnCombat")
RegisterUnitEvent(3452, 2, "SerenaBloodfeather_OnLeaveCombat")
RegisterUnitEvent(3452, 3, "SerenaBloodfeather_OnKilledTarget")
RegisterUnitEvent(3452, 4, "SerenaBloodfeather_OnDied")