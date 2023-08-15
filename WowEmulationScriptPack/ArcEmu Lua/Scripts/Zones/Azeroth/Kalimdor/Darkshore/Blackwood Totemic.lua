--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function BlackwoodTotemic_OnCombat(Unit, Event)
	Unit:RegisterEvent("BlackwoodTotemic_HealingWard", 13000, 0)
end

function BlackwoodTotemic_HealingWard(pUnit, Event) 
	pUnit:CastSpell(5606) 
end

function BlackwoodTotemic_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BlackwoodTotemic_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2169, 1, "BlackwoodTotemic_OnCombat")
RegisterUnitEvent(2169, 2, "BlackwoodTotemic_OnLeaveCombat")
RegisterUnitEvent(2169, 4, "BlackwoodTotemic_OnDied")