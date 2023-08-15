--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function FuryShelda_OnCombat(Unit, Event)
	Unit:RegisterEvent("FuryShelda_DeafeningScreech", 10000, 0)
end

function FuryShelda_DeafeningScreech(Unit, Event) 
	Unit:CastSpell(3589) 
end

function FuryShelda_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function FuryShelda_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function FuryShelda_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(14431, 1, "FuryShelda_OnCombat")
RegisterUnitEvent(14431, 2, "FuryShelda_OnLeaveCombat")
RegisterUnitEvent(14431, 3, "FuryShelda_OnKilledTarget")
RegisterUnitEvent(14431, 4, "FuryShelda_OnDied")