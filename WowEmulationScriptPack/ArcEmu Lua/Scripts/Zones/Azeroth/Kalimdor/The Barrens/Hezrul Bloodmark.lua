--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function HezrulBloodmark_OnCombat(Unit, Event)
	Unit:RegisterEvent("HezrulBloodmark_BloodLeech", 6000, 0)
end

function HezrulBloodmark_BloodLeech(Unit, Event) 
	Unit:FullCastSpellOnTarget(6958, 	Unit:GetMainTank()) 
end

function HezrulBloodmark_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HezrulBloodmark_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HezrulBloodmark_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3396, 1, "HezrulBloodmark_OnCombat")
RegisterUnitEvent(3396, 2, "HezrulBloodmark_OnLeaveCombat")
RegisterUnitEvent(3396, 3, "HezrulBloodmark_OnKilledTarget")
RegisterUnitEvent(3396, 4, "HezrulBloodmark_OnDied")