--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function DenMother_OnCombat(Unit, Event)
	Unit:RegisterEvent("DenMother_Ravage", 9000, 0)
end

function DenMother_Ravage(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3242, 	pUnit:GetMainTank()) 
end

function DenMother_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DenMother_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6788, 1, "DenMother_OnCombat")
RegisterUnitEvent(6788, 2, "DenMother_OnLeaveCombat")
RegisterUnitEvent(6788, 4, "DenMother_OnDied")