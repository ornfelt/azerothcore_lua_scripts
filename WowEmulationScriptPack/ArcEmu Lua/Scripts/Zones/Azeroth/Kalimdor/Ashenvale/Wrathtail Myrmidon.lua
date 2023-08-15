--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WrathtailMyrmidon_OnCombat(Unit, Event)
	Unit:RegisterEvent("WrathtailMyrmidon_Rend", 8000, 0)
	Unit:RegisterEvent("WrathtailMyrmidon_Strike", 6000, 0)
end

function WrathtailMyrmidon_Rend(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(11977, 	pUnit:GetMainTank()) 
end

function WrathtailMyrmidon_Strike(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(11976, 	pUnit:GetMainTank()) 
end

function WrathtailMyrmidon_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WrathtailMyrmidon_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3711, 1, "WrathtailMyrmidon_OnCombat")
RegisterUnitEvent(3711, 2, "WrathtailMyrmidon_OnLeaveCombat")
RegisterUnitEvent(3711, 4, "WrathtailMyrmidon_OnDied")