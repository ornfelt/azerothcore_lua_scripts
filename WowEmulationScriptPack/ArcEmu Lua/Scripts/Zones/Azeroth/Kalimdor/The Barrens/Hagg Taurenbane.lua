--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function HaggTaurenbane_OnCombat(Unit, Event)
	Unit:RegisterEvent("HaggTaurenbane_Cleave", 6000, 0)
	Unit:RegisterEvent("HaggTaurenbane_DemoralizingShout", 4000, 1)
	Unit:RegisterEvent("HaggTaurenbane_Hamstring", 10000, 0)
end

function HaggTaurenbane_Cleave(Unit, Event) 
	Unit:CastSpell(40505) 
end

function HaggTaurenbane_DemoralizingShout(Unit, Event) 
	Unit:CastSpell(13730) 
end

function HaggTaurenbane_Hamstring(Unit, Event) 
	Unit:FullCastSpellOnTarget(9080, 	Unit:GetMainTank()) 
end

function HaggTaurenbane_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HaggTaurenbane_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HaggTaurenbane_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5859, 1, "HaggTaurenbane_OnCombat")
RegisterUnitEvent(5859, 2, "HaggTaurenbane_OnLeaveCombat")
RegisterUnitEvent(5859, 3, "HaggTaurenbane_OnKilledTarget")
RegisterUnitEvent(5859, 4, "HaggTaurenbane_OnDied")