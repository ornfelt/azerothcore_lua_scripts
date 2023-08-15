--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function HaarkatheRavenous_OnCombat(Unit, Event)
	Unit:RegisterEvent("HaarkatheRavenous_SunderArmor", 10000, 0)
	Unit:RegisterEvent("HaarkatheRavenous_Thrash", 5000, 0)
end

function HaarkatheRavenous_SunderArmor(Unit, Event) 
	Unit:FullCastSpellOnTarget(21081, 	Unit:GetMainTank()) 
end

function HaarkatheRavenous_Thrash(Unit, Event) 
	Unit:FullCastSpellOnTarget(3391, 	Unit:GetMainTank()) 
end

function HaarkatheRavenous_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HaarkatheRavenous_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HaarkatheRavenous_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(8205, 1, "HaarkatheRavenous_OnCombat")
RegisterUnitEvent(8205, 2, "HaarkatheRavenous_OnLeaveCombat")
RegisterUnitEvent(8205, 3, "HaarkatheRavenous_OnKilledTarget")
RegisterUnitEvent(8205, 4, "HaarkatheRavenous_OnDied")