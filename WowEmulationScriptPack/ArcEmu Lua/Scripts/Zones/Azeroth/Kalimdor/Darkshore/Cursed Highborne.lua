--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CursedHighborne_OnCombat(Unit, Event)
	Unit:RegisterEvent("CursedHighborne_BansheeCurse", 9000, 0)
end

function CursedHighborne_BansheeCurse(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(5884, 	pUnit:GetMainTank()) 
end

function CursedHighborne_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function CursedHighborne_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2176, 1, "CursedHighborne_OnCombat")
RegisterUnitEvent(2176, 2, "CursedHighborne_OnLeaveCombat")
RegisterUnitEvent(2176, 4, "CursedHighborne_OnDied")