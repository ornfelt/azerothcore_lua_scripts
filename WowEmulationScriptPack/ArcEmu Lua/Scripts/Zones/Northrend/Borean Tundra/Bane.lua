--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Bane_OnCombat(Unit, Event)
	Unit:RegisterEvent("Bane_FoolsBane", 10000, 0)
end

function Bane_FoolsBane(Unit, Event) 
	Unit:CastSpell(50332) 
end

function Bane_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Bane_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Bane_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25655, 1, "Bane_OnCombat")
RegisterUnitEvent(25655, 2, "Bane_OnLeaveCombat")
RegisterUnitEvent(25655, 3, "Bane_OnKilledTarget")
RegisterUnitEvent(25655, 4, "Bane_OnDied")