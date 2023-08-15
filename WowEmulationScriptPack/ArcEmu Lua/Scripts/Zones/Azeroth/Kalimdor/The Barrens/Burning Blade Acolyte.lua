--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BurningBladeAcolyte_OnCombat(Unit, Event)
	Unit:RegisterEvent("BurningBladeAcolyte_CurseofAgony", 8000, 2)
	Unit:RegisterEvent("BurningBladeAcolyte_Inmolate", 3000, 2)
end

function BurningBladeAcolyte_CurseofAgony(Unit, Event) 
	Unit:FullCastSpellOnTarget(980, 	Unit:GetMainTank()) 
end

function BurningBladeAcolyte_Inmolate(Unit, Event) 
	Unit:FullCastSpellOnTarget(707, 	Unit:GetMainTank()) 
end

function BurningBladeAcolyte_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BurningBladeAcolyte_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function BurningBladeAcolyte_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3380, 1, "BurningBladeAcolyte_OnCombat")
RegisterUnitEvent(3380, 2, "BurningBladeAcolyte_OnLeaveCombat")
RegisterUnitEvent(3380, 3, "BurningBladeAcolyte_OnKilledTarget")
RegisterUnitEvent(3380, 4, "BurningBladeAcolyte_OnDied")