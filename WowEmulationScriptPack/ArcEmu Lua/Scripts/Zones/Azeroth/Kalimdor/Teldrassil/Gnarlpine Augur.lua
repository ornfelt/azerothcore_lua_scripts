--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GnarlpineAugur_OnCombat(Unit, Event)
	Unit:RegisterEvent("GnarlpineAugur_GnarlpineVengance", 8000, 0)
end

function GnarlpineAugur_GnarlpineVengance(Unit, Event) 
	Unit:CastSpell(5628) 
end

function GnarlpineAugur_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GnarlpineAugur_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function GnarlpineAugur_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2011, 1, "GnarlpineAugur_OnCombat")
RegisterUnitEvent(2011, 2, "GnarlpineAugur_OnLeaveCombat")
RegisterUnitEvent(2011, 3, "GnarlpineAugur_OnKilledTarget")
RegisterUnitEvent(2011, 4, "GnarlpineAugur_OnDied")