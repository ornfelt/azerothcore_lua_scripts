--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function RazormaneThornweaver_OnCombat(Unit, Event)
	Unit:RegisterEvent("RazormaneThornweaver_FaerieFire", 8000, 1)
	Unit:RegisterEvent("RazormaneThornweaver_Thorns", 2000, 1)
end

function RazormaneThornweaver_FaerieFire(Unit, Event) 
	Unit:FullCastSpellOnTarget(6950, 	Unit:GetMainTank()) 
end

function RazormaneThornweaver_Thorns(Unit, Event) 
	Unit:CastSpell(467) 
end

function RazormaneThornweaver_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RazormaneThornweaver_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function RazormaneThornweaver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3268, 1, "RazormaneThornweaver_OnCombat")
RegisterUnitEvent(3268, 2, "RazormaneThornweaver_OnLeaveCombat")
RegisterUnitEvent(3268, 3, "RazormaneThornweaver_OnKilledTarget")
RegisterUnitEvent(3268, 4, "RazormaneThornweaver_OnDied")