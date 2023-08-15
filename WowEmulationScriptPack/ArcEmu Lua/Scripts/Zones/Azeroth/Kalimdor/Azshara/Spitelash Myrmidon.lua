--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SpitelashMyrmidon_OnCombat(Unit, Event)
	Unit:RegisterEvent("SpitelashMyrmidon_Strike", 5000, 0)
end

function SpitelashMyrmidon_Strike(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(11976, 	pUnit:GetMainTank()) 
end

function SpitelashMyrmidon_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SpitelashMyrmidon_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6196, 1, "SpitelashMyrmidon_OnCombat")
RegisterUnitEvent(6196, 2, "SpitelashMyrmidon_OnLeaveCombat")
RegisterUnitEvent(6196, 4, "SpitelashMyrmidon_OnDied")