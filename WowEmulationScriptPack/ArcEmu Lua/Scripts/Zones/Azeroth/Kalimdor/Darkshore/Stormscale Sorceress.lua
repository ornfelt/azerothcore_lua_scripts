--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function StormscaleSorceress_OnCombat(Unit, Event)
	Unit:RegisterEvent("StormscaleSorceress_FrostArmor", 2000, 1)
	Unit:RegisterEvent("StormscaleSorceress_Frostbolt", 8000, 0)
end

function StormscaleSorceress_FrostArmor(pUnit, Event) 
	pUnit:CastSpell(12544) 
end

function StormscaleSorceress_Frostbolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(20792, 	pUnit:GetMainTank()) 
end

function StormscaleSorceress_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function StormscaleSorceress_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2182, 1, "StormscaleSorceress_OnCombat")
RegisterUnitEvent(2182, 2, "StormscaleSorceress_OnLeaveCombat")
RegisterUnitEvent(2182, 4, "StormscaleSorceress_OnDied")