--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Sharptalon_OnCombat(Unit, Event)
	Unit:RegisterEvent("Sharptalon_PierceArmor", 6000, 0)
end

function Sharptalon_PierceArmor(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12097, 	pUnit:GetMainTank()) 
end

function Sharptalon_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Sharptalon_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(12676, 1, "Sharptalon_OnCombat")
RegisterUnitEvent(12676, 2, "Sharptalon_OnLeaveCombat")
RegisterUnitEvent(12676, 4, "Sharptalon_OnDied")