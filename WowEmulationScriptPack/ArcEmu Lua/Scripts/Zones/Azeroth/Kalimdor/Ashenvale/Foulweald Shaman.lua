--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function FoulwealdShaman_OnCombat(Unit, Event)
	Unit:RegisterEvent("FoulwealdShaman_StrengthofEarthTotem", 2000, 1)
end

function FoulwealdShaman_StrengthofEarthTotem(pUnit, Event) 
	pUnit:CastSpell(8160) 
end

function FoulwealdShaman_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function FoulwealdShaman_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3748, 1, "FoulwealdShaman_OnCombat")
RegisterUnitEvent(3748, 2, "FoulwealdShaman_OnLeaveCombat")
RegisterUnitEvent(3748, 4, "FoulwealdShaman_OnDied")