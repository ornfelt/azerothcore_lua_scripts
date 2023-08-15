--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function FerocitastheDreamEater_OnCombat(Unit, Event)
	Unit:RegisterEvent("FerocitastheDreamEater_Thrash", 5000, 0)
end

function FerocitastheDreamEater_Thrash(Unit, Event) 
	Unit:FullCastSpellOnTarget(3391, 	Unit:GetMainTank()) 
end

function FerocitastheDreamEater_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function FerocitastheDreamEater_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function FerocitastheDreamEater_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(7234, 1, "FerocitastheDreamEater_OnCombat")
RegisterUnitEvent(7234, 2, "FerocitastheDreamEater_OnLeaveCombat")
RegisterUnitEvent(7234, 3, "FerocitastheDreamEater_OnKilledTarget")
RegisterUnitEvent(7234, 4, "FerocitastheDreamEater_OnDied")