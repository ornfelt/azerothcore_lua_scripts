--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BristlelimbWindcaller_OnCombat(Unit, Event)
	Unit:RegisterEvent("BristlelimbWindcaller_Rejuvenation", 13000, 0)
	Unit:RegisterEvent("BristlelimbWindcaller_WindShock", 8000, 0)
end

function BristlelimbWindcaller_Rejuvenation(pUnit, Event) 
	pUnit:CastSpell(32131) 
end

function BristlelimbWindcaller_WindShock(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(31272, 	pUnit:GetMainTank()) 
end

function BristlelimbWindcaller_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BristlelimbWindcaller_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17184, 1, "BristlelimbWindcaller_OnCombat")
RegisterUnitEvent(17184, 2, "BristlelimbWindcaller_OnLeaveCombat")
RegisterUnitEvent(17184, 4, "BristlelimbWindcaller_OnDied")