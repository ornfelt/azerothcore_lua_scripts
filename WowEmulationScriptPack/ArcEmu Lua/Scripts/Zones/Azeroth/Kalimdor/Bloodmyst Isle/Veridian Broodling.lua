--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function VeridianBroodling_OnCombat(Unit, Event)
	Unit:RegisterEvent("VeridianBroodling_PoisonBolt", 8000, 0)
end

function VeridianBroodling_PoisonBolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(21067, 	pUnit:GetMainTank()) 
end

function VeridianBroodling_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function VeridianBroodling_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17589, 1, "VeridianBroodling_OnCombat")
RegisterUnitEvent(17589, 2, "VeridianBroodling_OnLeaveCombat")
RegisterUnitEvent(17589, 4, "VeridianBroodling_OnDied")