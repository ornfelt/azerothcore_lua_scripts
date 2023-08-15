--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BurningBladeToxicologist_OnCombat(Unit, Event)
	Unit:RegisterEvent("BurningBladeToxicologist_CurseofAgony", 8000, 2)
	Unit:RegisterEvent("BurningBladeToxicologist_Inmolate", 3000, 2)
end

function BurningBladeToxicologist_CurseofAgony(Unit, Event) 
	Unit:FullCastSpellOnTarget(980, 	Unit:GetMainTank()) 
end

function BurningBladeToxicologist_Inmolate(Unit, Event) 
	Unit:FullCastSpellOnTarget(707, 	Unit:GetMainTank()) 
end

function BurningBladeToxicologist_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BurningBladeToxicologist_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function BurningBladeToxicologist_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(12319, 1, "BurningBladeToxicologist_OnCombat")
RegisterUnitEvent(12319, 2, "BurningBladeToxicologist_OnLeaveCombat")
RegisterUnitEvent(12319, 3, "BurningBladeToxicologist_OnKilledTarget")
RegisterUnitEvent(12319, 4, "BurningBladeToxicologist_OnDied")