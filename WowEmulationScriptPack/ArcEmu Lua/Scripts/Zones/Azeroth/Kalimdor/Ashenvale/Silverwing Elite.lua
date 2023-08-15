--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SilverwingElite_OnCombat(Unit, Event)
	Unit:RegisterEvent("SilverwingElite_Shoot", 6000, 0)
end

function SilverwingElite_Shoot(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6660, 	pUnit:GetMainTank()) 
end

function SilverwingElite_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SilverwingElite_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(14715, 1, "SilverwingElite_OnCombat")
RegisterUnitEvent(14715, 2, "SilverwingElite_OnLeaveCombat")
RegisterUnitEvent(14715, 4, "SilverwingElite_OnDied")