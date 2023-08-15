--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SunhawkPyromancer_OnCombat(Unit, Event)
	Unit:RegisterEvent("SunhawkPyromancer_Fireball", 8000, 0)
	Unit:RegisterEvent("SunhawkPyromancer_Immolate", 6000, 1)
	Unit:RegisterEvent("SunhawkPyromancer_MarkoftheSunhawk", 7500, 0)
end

function SunhawkPyromancer_Fireball(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9053, 	pUnit:GetMainTank()) 
end

function SunhawkPyromancer_Immolate(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(11962, 	pUnit:GetMainTank()) 
end

function SunhawkPyromancer_MarkoftheSunhawk(pUnit, Event) 
	pUnit:CastSpell(31734) 
end

function SunhawkPyromancer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SunhawkPyromancer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17608, 1, "SunhawkPyromancer_OnCombat")
RegisterUnitEvent(17608, 2, "SunhawkPyromancer_OnLeaveCombat")
RegisterUnitEvent(17608, 4, "SunhawkPyromancer_OnDied")