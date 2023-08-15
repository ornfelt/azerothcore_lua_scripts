--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DreadRipper_OnCombat(Unit, Event)
	Unit:RegisterEvent("DreadRipper_RendFlesh", 8000, 0)
end

function DreadRipper_RendFlesh(Unit, Event) 
	Unit:FullCastSpellOnTarget(3147, 	Unit:GetMainTank()) 
end

function DreadRipper_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DreadRipper_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(4694, 1, "DreadRipper_OnCombat")
RegisterUnitEvent(4694, 2, "DreadRipper_OnLeaveCombat")
RegisterUnitEvent(4694, 4, "DreadRipper_OnDied")