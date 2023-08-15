--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function RazormaneHunter_OnCombat(Unit, Event)
	Unit:RegisterEvent("RazormaneHunter_Shoot", 6000, 0)
	Unit:RegisterEvent("RazormaneHunter_RazormaneWolf", 3000, 1)
end

function RazormaneHunter_Shoot(Unit, Event) 
	Unit:FullCastSpellOnTarget(6660, 	Unit:GetMainTank()) 
end

function RazormaneHunter_RazormaneWolf(Unit, Event) 
	Unit:CastSpell(6479) 
end

function RazormaneHunter_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RazormaneHunter_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function RazormaneHunter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3265, 1, "RazormaneHunter_OnCombat")
RegisterUnitEvent(3265, 2, "RazormaneHunter_OnLeaveCombat")
RegisterUnitEvent(3265, 3, "RazormaneHunter_OnKilledTarget")
RegisterUnitEvent(3265, 4, "RazormaneHunter_OnDied")