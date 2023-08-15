--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Xilxix_OnCombat(Unit, Event)
	Unit:RegisterEvent("Xilxix_BerserkerCharge", 6000, 0)
end

function Xilxix_BerserkerCharge(Unit, Event) 
	Unit:FullCastSpellOnTarget(19471, 	Unit:GetRandomPlayer(0)) 
end

function Xilxix_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Xilxix_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Xilxix_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(15286, 1, "Xilxix_OnCombat")
RegisterUnitEvent(15286, 2, "Xilxix_OnLeaveCombat")
RegisterUnitEvent(15286, 3, "Xilxix_OnKilledTarget")
RegisterUnitEvent(15286, 4, "Xilxix_OnDied")