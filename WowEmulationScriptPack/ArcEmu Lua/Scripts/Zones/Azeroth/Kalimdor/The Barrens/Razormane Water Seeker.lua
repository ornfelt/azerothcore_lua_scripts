--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function RazormaneWaterSeeker_OnCombat(Unit, Event)
	Unit:RegisterEvent("RazormaneWaterSeeker_CreepingMold", 4000, 1)
end

function RazormaneWaterSeeker_CreepingMold(Unit, Event) 
	Unit:FullCastSpellOnTarget(6278, 	Unit:GetMainTank()) 
end

function RazormaneWaterSeeker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RazormaneWaterSeeker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function RazormaneWaterSeeker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3267, 1, "RazormaneWaterSeeker_OnCombat")
RegisterUnitEvent(3267, 2, "RazormaneWaterSeeker_OnLeaveCombat")
RegisterUnitEvent(3267, 3, "RazormaneWaterSeeker_OnKilledTarget")
RegisterUnitEvent(3267, 4, "RazormaneWaterSeeker_OnDied")