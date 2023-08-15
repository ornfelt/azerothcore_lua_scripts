--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function StormscaleSiren_OnCombat(Unit, Event)
	Unit:RegisterEvent("StormscaleSiren_Heal", 13000, 0)
	Unit:RegisterEvent("StormscaleSiren_HolySmite", 8000, 0)
end

function StormscaleSiren_Heal(pUnit, Event) 
	pUnit:CastSpell(11642) 
end

function StormscaleSiren_HolySmite(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9734, 	pUnit:GetMainTank()) 
end

function StormscaleSiren_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function StormscaleSiren_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2180, 1, "StormscaleSiren_OnCombat")
RegisterUnitEvent(2180, 2, "StormscaleSiren_OnLeaveCombat")
RegisterUnitEvent(2180, 4, "StormscaleSiren_OnDied")