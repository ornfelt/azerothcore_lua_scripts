--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GnarlpineAvenger_OnCombat(Unit, Event)
	Unit:RegisterEvent("GnarlpineAvenger_GnarlpineVengance", 8000, 0)
end

function GnarlpineAvenger_GnarlpineVengance(Unit, Event) 
	Unit:CastSpell(5628) 
end

function GnarlpineAvenger_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GnarlpineAvenger_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function GnarlpineAvenger_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2011, 1, "GnarlpineAvenger_OnCombat")
RegisterUnitEvent(2011, 2, "GnarlpineAvenger_OnLeaveCombat")
RegisterUnitEvent(2011, 3, "GnarlpineAvenger_OnKilledTarget")
RegisterUnitEvent(2011, 4, "GnarlpineAvenger_OnDied")