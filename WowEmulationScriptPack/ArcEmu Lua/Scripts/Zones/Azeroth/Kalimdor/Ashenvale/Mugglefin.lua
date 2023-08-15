--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Mugglefin_OnCombat(Unit, Event)
	Unit:RegisterEvent("Mugglefin_VolatileInfection", 12000, 0)
end

function Mugglefin_VolatileInfection(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3584, 	pUnit:GetMainTank()) 
end

function Mugglefin_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Mugglefin_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(10643, 1, "Mugglefin_OnCombat")
RegisterUnitEvent(10643, 2, "Mugglefin_OnLeaveCombat")
RegisterUnitEvent(10643, 4, "Mugglefin_OnDied")