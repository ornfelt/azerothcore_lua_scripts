--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GnarlpineMystic_OnCombat(Unit, Event)
	Unit:RegisterEvent("GnarlpineMystic_Wrath", 6000, 0)
end

function GnarlpineMystic_Wrath(Unit, Event) 
	Unit:FullCastSpellOnTarget(9739, 	Unit:GetMainTank()) 
end

function GnarlpineMystic_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GnarlpineMystic_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function GnarlpineMystic_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(7235, 1, "GnarlpineMystic_OnCombat")
RegisterUnitEvent(7235, 2, "GnarlpineMystic_OnLeaveCombat")
RegisterUnitEvent(7235, 3, "GnarlpineMystic_OnKilledTarget")
RegisterUnitEvent(7235, 4, "GnarlpineMystic_OnDied")