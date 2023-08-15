--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function KodoCalf_OnCombat(Unit, Event)
Unit:RegisterEvent("KodoCalf_RushingCharge", 10000, 0)
end

function KodoCalf_RushingCharge(pUnit, Event) 
pUnit:FullCastSpellOnTarget(6268, pUnit:GetMainTank()) 
end

function KodoCalf_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function KodoCalf_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function KodoCalf_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2972, 1, "KodoCalf_OnCombat")
RegisterUnitEvent(2972, 2, "KodoCalf_OnLeaveCombat")
RegisterUnitEvent(2972, 3, "KodoCalf_OnKilledTarget")
RegisterUnitEvent(2972, 4, "KodoCalf_OnDied")