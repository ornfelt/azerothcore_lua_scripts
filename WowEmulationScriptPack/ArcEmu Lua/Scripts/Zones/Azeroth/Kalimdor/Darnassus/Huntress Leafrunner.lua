--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function HuntressLeafrunner_OnCombat(	Unit, Event)
	Unit:RegisterEvent("HuntressLeafrunner_HookedNet", 13000, 0)
	Unit:RegisterEvent("HuntressLeafrunner_SunderArmor", 8000, 0)
end

function HuntressLeafrunner_HookedNet(	Unit, Event) 
	Unit:FullCastSpellOnTarget(14030, 	Unit:GetMainTank()) 
end

function HuntressLeafrunner_SunderArmor(	Unit, Event) 
	Unit:FullCastSpellOnTarget(15572, 	Unit:GetMainTank()) 
end

function HuntressLeafrunner_OnLeaveCombat(	Unit, Event) 
	Unit:RemoveEvents() 
end

function HuntressLeafrunner_OnDied(	Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(14380, 1, "HuntressLeafrunner_OnCombat")
RegisterUnitEvent(14380, 2, "HuntressLeafrunner_OnLeaveCombat")
RegisterUnitEvent(14380, 4, "HuntressLeafrunner_OnDied")