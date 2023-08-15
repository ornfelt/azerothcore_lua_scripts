--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BlackwoodWindtalker_OnCombat(Unit, Event)
	Unit:RegisterEvent("BlackwoodWindtalker_GustofWind", 9000, 0)
end

function BlackwoodWindtalker_GustofWind(pUnit, Event) 
	pUnit:CastSpell(6982) 
end

function BlackwoodWindtalker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BlackwoodWindtalker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2324, 1, "BlackwoodWindtalker_OnCombat")
RegisterUnitEvent(2324, 2, "BlackwoodWindtalker_OnLeaveCombat")
RegisterUnitEvent(2324, 4, "BlackwoodWindtalker_OnDied")