--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WitchwingHarpy_OnCombat(Unit, Event)
	Unit:RegisterEvent("WitchwingHarpy_CurseofMending", 4000, 1)
end

function WitchwingHarpy_CurseofMending(Unit, Event) 
	Unit:FullCastSpellOnTarget(7098, 	Unit:GetMainTank()) 
end

function WitchwingHarpy_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WitchwingHarpy_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function WitchwingHarpy_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3276, 1, "WitchwingHarpy_OnCombat")
RegisterUnitEvent(3276, 2, "WitchwingHarpy_OnLeaveCombat")
RegisterUnitEvent(3276, 3, "WitchwingHarpy_OnKilledTarget")
RegisterUnitEvent(3276, 4, "WitchwingHarpy_OnDied")