--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HuntressSkymane_OnCombat(	Unit, Event)
	Unit:RegisterEvent("HuntressSkymane_HookedNet", 13000, 0)
	Unit:RegisterEvent("HuntressSkymane_SunderArmor", 8000, 0)
end

function HuntressSkymane_HookedNet(	Unit, Event) 
	Unit:FullCastSpellOnTarget(14030, 	Unit:GetMainTank()) 
end

function HuntressSkymane_SunderArmor(	Unit, Event) 
	Unit:FullCastSpellOnTarget(15572, 	Unit:GetMainTank()) 
end

function HuntressSkymane_OnLeaveCombat(	Unit, Event) 
	Unit:RemoveEvents() 
end

function HuntressSkymane_OnDied(	Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(14378, 1, "HuntressSkymane_OnCombat")
RegisterUnitEvent(14378, 2, "HuntressSkymane_OnLeaveCombat")
RegisterUnitEvent(14378, 4, "HuntressSkymane_OnDied")