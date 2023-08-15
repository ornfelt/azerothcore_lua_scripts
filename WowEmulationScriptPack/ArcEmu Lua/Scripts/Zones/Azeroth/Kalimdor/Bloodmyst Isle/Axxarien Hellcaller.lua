--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function AxxarienHellcaller_OnCombat(Unit, Event)
	Unit:RegisterEvent("AxxarienHellcaller_RainOfFire", 10000, 0)
end

function AxxarienHellcaller_RainOfFire(pUnit, Event) 
	pUnit:CastSpell(11990) 
end

function AxxarienHellcaller_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function AxxarienHellcaller_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17342, 1, "AxxarienHellcaller_OnCombat")
RegisterUnitEvent(17342, 2, "AxxarienHellcaller_OnLeaveCombat")
RegisterUnitEvent(17342, 4, "AxxarienHellcaller_OnDied")