--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CookieMcWeaksauce_OnCombat(Unit, Event)
	Unit:RegisterEvent("CookieMcWeaksauce_Shoot", 6000, 0)
end

function CookieMcWeaksauce_Shoot(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(30221, 	pUnit:GetRandomPlayer(0)) 
end

function CookieMcWeaksauce_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function CookieMcWeaksauce_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17246, 1, "CookieMcWeaksauce_OnCombat")
RegisterUnitEvent(17246, 2, "CookieMcWeaksauce_OnLeaveCombat")
RegisterUnitEvent(17246, 4, "CookieMcWeaksauce_OnDied")