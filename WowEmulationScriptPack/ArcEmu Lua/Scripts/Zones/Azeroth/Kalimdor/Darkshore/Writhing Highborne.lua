--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Xabraxxis_OnCombat(Unit, Event)
	Unit:RegisterEvent("Xabraxxis_CurseofWeakness", 4000, 1)
	Unit:RegisterEvent("Xabraxxis_Enrage", 10000, 1)
	Unit:RegisterEvent("Xabraxxis_ShadowWordPain", 11390, 0)
end

function Xabraxxis_CurseofWeakness(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(11980, 	pUnit:GetMainTank()) 
end

function Xabraxxis_Enrage(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(8599, 	pUnit:GetMainTank()) 
end

function Xabraxxis_ShadowWordPain(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(11639, 	pUnit:GetMainTank()) 
end

function Xabraxxis_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Xabraxxis_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(10373, 1, "Xabraxxis_OnCombat")
RegisterUnitEvent(10373, 2, "Xabraxxis_OnLeaveCombat")
RegisterUnitEvent(10373, 4, "Xabraxxis_OnDied")