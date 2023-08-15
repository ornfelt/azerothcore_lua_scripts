--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function DarkStrandFanatic_OnCombat(Unit, Event)
	Unit:RegisterEvent("DarkStrandFanatic_CurseofMending", 5000, 1)
end

function DarkStrandFanatic_CurseofMending(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(7098, 	pUnit:GetMainTank()) 
end

function DarkStrandFanatic_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DarkStrandFanatic_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2336, 1, "DarkStrandFanatic_OnCombat")
RegisterUnitEvent(2336, 2, "DarkStrandFanatic_OnLeaveCombat")
RegisterUnitEvent(2336, 4, "DarkStrandFanatic_OnDied")