--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BlackwoodUrsa_OnCombat(Unit, Event)
	Unit:RegisterEvent("BlackwoodUrsa_Rejuvenation", 10000, 0)
end

function BlackwoodUrsa_Rejuvenation(pUnit, Event) 
	pUnit:CastSpell(1058) 
end

function BlackwoodUrsa_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BlackwoodUrsa_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2170, 1, "BlackwoodUrsa_OnCombat")
RegisterUnitEvent(2170, 2, "BlackwoodUrsa_OnLeaveCombat")
RegisterUnitEvent(2170, 4, "BlackwoodUrsa_OnDied")