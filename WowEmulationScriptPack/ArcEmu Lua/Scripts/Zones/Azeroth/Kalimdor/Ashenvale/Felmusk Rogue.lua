--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function FelmuskRogue_OnCombat(Unit, Event)
	Unit:RegisterEvent("FelmuskRogue_OverwhelmingStench", 10000, 0)
end

function FelmuskRogue_OverwhelmingStench(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6942, 	pUnit:GetMainTank()) 
end

function FelmuskRogue_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function FelmuskRogue_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3759, 1, "FelmuskRogue_OnCombat")
RegisterUnitEvent(3759, 2, "FelmuskRogue_OnLeaveCombat")
RegisterUnitEvent(3759, 4, "FelmuskRogue_OnDied")