--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function DunemaulWarlock_OnCombat(Unit, Event)
	Unit:RegisterEvent("DunemaulWarlock_Shadowbolt", 8000, 0)
end

function DunemaulWarlock_Shadowbolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(9613, 	Unit:GetMainTank()) 
end

function DunemaulWarlock_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DunemaulWarlock_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function DunemaulWarlock_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5475, 1, "DunemaulWarlock_OnCombat")
RegisterUnitEvent(5475, 2, "DunemaulWarlock_OnLeaveCombat")
RegisterUnitEvent(5475, 3, "DunemaulWarlock_OnKilledTarget")
RegisterUnitEvent(5475, 4, "DunemaulWarlock_OnDied")