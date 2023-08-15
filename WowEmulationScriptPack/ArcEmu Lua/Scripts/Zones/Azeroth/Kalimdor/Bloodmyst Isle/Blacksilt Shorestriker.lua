--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BlacksiltShorestriker_OnCombat(Unit, Event)
	Unit:RegisterEvent("BlacksiltShorestriker_Net", 8000, 0)
end

function BlacksiltShorestriker_Net(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(31290, 	pUnit:GetMainTank()) 
end

function BlacksiltShorestriker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BlacksiltShorestriker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17328, 1, "BlacksiltShorestriker_OnCombat")
RegisterUnitEvent(17328, 2, "BlacksiltShorestriker_OnLeaveCombat")
RegisterUnitEvent(17328, 4, "BlacksiltShorestriker_OnDied")