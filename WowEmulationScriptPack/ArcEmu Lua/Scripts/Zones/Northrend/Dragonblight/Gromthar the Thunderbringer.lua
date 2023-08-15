--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GromthartheThunderbringer_OnCombat(Unit, Event)
Unit:RegisterEvent("GromthartheThunderbringer_MagnataurCharge", 8000, 0)
Unit:RegisterEvent("GromthartheThunderbringer_Thunder", 10000, 0)
end

function GromthartheThunderbringer_MagnataurCharge(Unit, Event) 
Unit:FullCastSpellOnTarget(52169, Unit:GetMainTank()) 
end

function GromthartheThunderbringer_Thunder(Unit, Event) 
Unit:CastSpell(52166) 
end

function GromthartheThunderbringer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GromthartheThunderbringer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GromthartheThunderbringer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27002, 1, "GromthartheThunderbringer_OnCombat")
RegisterUnitEvent(27002, 2, "GromthartheThunderbringer_OnLeaveCombat")
RegisterUnitEvent(27002, 3, "GromthartheThunderbringer_OnKilledTarget")
RegisterUnitEvent(27002, 4, "GromthartheThunderbringer_OnDied")