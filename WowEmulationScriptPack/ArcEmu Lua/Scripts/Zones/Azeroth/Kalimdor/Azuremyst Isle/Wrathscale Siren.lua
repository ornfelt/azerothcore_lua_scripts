--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WrathscaleSiren_OnCombat(Unit, Event)
	Unit:RegisterEvent("WrathscaleSiren_Screech", 8000, 0)
end

function WrathscaleSiren_Screech(pUnit, Event) 
	pUnit:CastSpell(31273) 
end

function WrathscaleSiren_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WrathscaleSiren_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17195, 1, "WrathscaleSiren_OnCombat")
RegisterUnitEvent(17195, 2, "WrathscaleSiren_OnLeaveCombat")
RegisterUnitEvent(17195, 4, "WrathscaleSiren_OnDied")