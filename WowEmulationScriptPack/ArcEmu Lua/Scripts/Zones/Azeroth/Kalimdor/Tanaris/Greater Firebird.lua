--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GreaterFirebird_OnCombat(Unit, Event)
	Unit:RegisterEvent("GreaterFirebird_CrimsonFury", 8000, 0)
	Unit:RegisterEvent("GreaterFirebird_FireNova", 10000, 0)
end

function GreaterFirebird_CrimsonFury(Unit, Event) 
	Unit:CastSpell(16843) 
end

function GreaterFirebird_FireNova(Unit, Event) 
	Unit:CastSpell(11970) 
end

function GreaterFirebird_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GreaterFirebird_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function GreaterFirebird_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(8207, 1, "GreaterFirebird_OnCombat")
RegisterUnitEvent(8207, 2, "GreaterFirebird_OnLeaveCombat")
RegisterUnitEvent(8207, 3, "GreaterFirebird_OnKilledTarget")
RegisterUnitEvent(8207, 4, "GreaterFirebird_OnDied")