--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function DunemaulBrute_OnCombat(Unit, Event)
	Unit:RegisterEvent("DunemaulBrute_Uppercut", 7000, 0)
end

function DunemaulBrute_Uppercut(Unit, Event) 
	Unit:FullCastSpellOnTarget(10966, 	Unit:GetMainTank()) 
end

function DunemaulBrute_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DunemaulBrute_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function DunemaulBrute_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5474, 1, "DunemaulBrute_OnCombat")
RegisterUnitEvent(5474, 2, "DunemaulBrute_OnLeaveCombat")
RegisterUnitEvent(5474, 3, "DunemaulBrute_OnKilledTarget")
RegisterUnitEvent(5474, 4, "DunemaulBrute_OnDied")