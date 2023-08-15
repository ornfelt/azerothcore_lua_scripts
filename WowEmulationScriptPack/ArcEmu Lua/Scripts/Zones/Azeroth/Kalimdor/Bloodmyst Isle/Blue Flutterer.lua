--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BlueFlutterer_OnCombat(Unit, Event)
	Unit:RegisterEvent("BlueFlutterer_Rake", 10000, 0)
end

function BlueFlutterer_Rake(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(36332, 	pUnit:GetMainTank()) 
end

function BlueFlutterer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BlueFlutterer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17349, 1, "BlueFlutterer_OnCombat")
RegisterUnitEvent(17349, 2, "BlueFlutterer_OnLeaveCombat")
RegisterUnitEvent(17349, 4, "BlueFlutterer_OnDied")