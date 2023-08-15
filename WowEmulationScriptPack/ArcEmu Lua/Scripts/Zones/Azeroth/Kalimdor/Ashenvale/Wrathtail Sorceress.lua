--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WrathtailSorceress_OnCombat(Unit, Event)
	Unit:RegisterEvent("WrathtailSorceress_Frostbolt", 7000, 0)
end

function WrathtailSorceress_Frostbolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(20792, 	pUnit:GetMainTank()) 
end

function WrathtailSorceress_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WrathtailSorceress_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3717, 1, "WrathtailSorceress_OnCombat")
RegisterUnitEvent(3717, 2, "WrathtailSorceress_OnLeaveCombat")
RegisterUnitEvent(3717, 4, "WrathtailSorceress_OnDied")