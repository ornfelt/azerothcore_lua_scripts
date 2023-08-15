--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HuntressRavenoak_OnCombat(	Unit, Event)
	Unit:RegisterEvent("HuntressRavenoak_HookedNet", 13000, 0)
	Unit:RegisterEvent("HuntressRavenoak_SunderArmor", 8000, 0)
end

function HuntressRavenoak_HookedNet(	Unit, Event) 
	Unit:FullCastSpellOnTarget(14030, 	Unit:GetMainTank()) 
end

function HuntressRavenoak_SunderArmor(	Unit, Event) 
	Unit:FullCastSpellOnTarget(15572, 	Unit:GetMainTank()) 
end

function HuntressRavenoak_OnLeaveCombat(	Unit, Event) 
	Unit:RemoveEvents() 
end

function HuntressRavenoak_OnDied(	Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(14379, 1, "HuntressRavenoak_OnCombat")
RegisterUnitEvent(14379, 2, "HuntressRavenoak_OnLeaveCombat")
RegisterUnitEvent(14379, 4, "HuntressRavenoak_OnDied")