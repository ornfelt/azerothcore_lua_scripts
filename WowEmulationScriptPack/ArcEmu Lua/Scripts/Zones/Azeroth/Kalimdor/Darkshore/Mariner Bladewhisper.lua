--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function MarinerBladewhisper_OnCombat(Unit, Event)
	Unit:RegisterEvent("MarinerBladewhisper_Net", 10000, 0)
end

function MarinerBladewhisper_Net(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12024, 	pUnit:GetMainTank()) 
end

function MarinerBladewhisper_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MarinerBladewhisper_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(24996, 1, "MarinerBladewhisper_OnCombat")
RegisterUnitEvent(24996, 2, "MarinerBladewhisper_OnLeaveCombat")
RegisterUnitEvent(24996, 4, "MarinerBladewhisper_OnDied")