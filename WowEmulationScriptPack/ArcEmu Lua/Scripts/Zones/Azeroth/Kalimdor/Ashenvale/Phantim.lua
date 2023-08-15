--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Phantim_OnCombat(Unit, Event)
	Unit:RegisterEvent("Phantim_CorrosiveAcidBreath", 8000, 0)
end

function Phantim_CorrosiveAcidBreath(pUnit, Event) 
	pUnit:CastSpell(20667) 
end

function Phantim_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Phantim_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(5314, 1, "Phantim_OnCombat")
RegisterUnitEvent(5314, 2, "Phantim_OnLeaveCombat")
RegisterUnitEvent(5314, 4, "Phantim_OnDied")