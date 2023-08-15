--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GnarlpineTotemic_OnCombat(Unit, Event)
	Unit:RegisterEvent("GnarlpineTotemic_GnarlpineVengeance", 10000, 0)
	Unit:RegisterEvent("GnarlpineTotemic_HealingWard", 12000, 0)
end

function GnarlpineTotemic_GnarlpineVengeance(Unit, Event) 
	Unit:CastSpell(5628) 
end

function GnarlpineTotemic_HealingWard(Unit, Event) 
	Unit:CastSpell(5605) 
end

function GnarlpineTotemic_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GnarlpineTotemic_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function GnarlpineTotemic_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2014, 1, "GnarlpineTotemic_OnCombat")
RegisterUnitEvent(2014, 2, "GnarlpineTotemic_OnLeaveCombat")
RegisterUnitEvent(2014, 3, "GnarlpineTotemic_OnKilledTarget")
RegisterUnitEvent(2014, 4, "GnarlpineTotemic_OnDied")