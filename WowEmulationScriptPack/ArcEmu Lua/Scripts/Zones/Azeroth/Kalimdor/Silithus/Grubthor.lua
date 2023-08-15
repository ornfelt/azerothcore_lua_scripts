--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Grubthor_OnCombat(Unit, Event)
	Unit:RegisterEvent("Grubthor_Tramble", 6000, 0)
end

function Grubthor_Tramble(Unit, Event) 
	Unit:CastSpell(5568) 
end

function Grubthor_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Grubthor_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Grubthor_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(14477, 1, "Grubthor_OnCombat")
RegisterUnitEvent(14477, 2, "Grubthor_OnLeaveCombat")
RegisterUnitEvent(14477, 3, "Grubthor_OnKilledTarget")
RegisterUnitEvent(14477, 4, "Grubthor_OnDied")