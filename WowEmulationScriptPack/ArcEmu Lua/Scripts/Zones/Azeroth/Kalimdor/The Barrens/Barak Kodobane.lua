--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BarakKodobane_OnCombat(Unit, Event)
	Unit:RegisterEvent("BarakKodobane_Shoot", 6000, 0)
end

function BarakKodobane_Shoot(Unit, Event) 
	Unit:FullCastSpellOnTarget(6660, 	Unit:GetMainTank()) 
end

function BarakKodobane_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BarakKodobane_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function BarakKodobane_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3394, 1, "BarakKodobane_OnCombat")
RegisterUnitEvent(3394, 2, "BarakKodobane_OnLeaveCombat")
RegisterUnitEvent(3394, 3, "BarakKodobane_OnKilledTarget")
RegisterUnitEvent(3394, 4, "BarakKodobane_OnDied")