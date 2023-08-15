--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function RavagerSpecimen_OnCombat(Unit, Event)
	Unit:RegisterEvent("RavagerSpecimen_Rend", 8000, 0)
end

function RavagerSpecimen_Rend(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(13443, 	pUnit:GetMainTank()) 
end

function RavagerSpecimen_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RavagerSpecimen_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17199, 1, "RavagerSpecimen_OnCombat")
RegisterUnitEvent(17199, 2, "RavagerSpecimen_OnLeaveCombat")
RegisterUnitEvent(17199, 4, "RavagerSpecimen_OnDied")