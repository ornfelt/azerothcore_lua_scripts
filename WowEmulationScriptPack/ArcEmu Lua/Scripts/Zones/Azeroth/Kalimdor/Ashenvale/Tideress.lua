--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Tideress_OnCombat(Unit, Event)
	Unit:RegisterEvent("Tideress_Frostbolt", 7000, 0)
end

function Tideress_Frostbolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9672, 	pUnit:GetMainTank()) 
end

function Tideress_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Tideress_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(12759, 1, "Tideress_OnCombat")
RegisterUnitEvent(12759, 2, "Tideress_OnLeaveCombat")
RegisterUnitEvent(12759, 4, "Tideress_OnDied")