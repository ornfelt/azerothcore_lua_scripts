--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GnarlpinePathfinder_OnCombat(Unit, Event)
	Unit:RegisterEvent("GnarlpinePathfinder_GnarlpineVengeance", 10000, 0)
	Unit:RegisterEvent("GnarlpinePathfinder_Wrath", 6000, 0)
end

function GnarlpinePathfinder_GnarlpineVengeance(Unit, Event) 
	Unit:CastSpell(5628) 
end

function GnarlpinePathfinder_Wrath(Unit, Event) 
	Unit:FullCastSpellOnTarget(9739, 	Unit:GetMainTank()) 
end

function GnarlpinePathfinder_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GnarlpinePathfinder_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function GnarlpinePathfinder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2012, 1, "GnarlpinePathfinder_OnCombat")
RegisterUnitEvent(2012, 2, "GnarlpinePathfinder_OnLeaveCombat")
RegisterUnitEvent(2012, 3, "GnarlpinePathfinder_OnKilledTarget")
RegisterUnitEvent(2012, 4, "GnarlpinePathfinder_OnDied")