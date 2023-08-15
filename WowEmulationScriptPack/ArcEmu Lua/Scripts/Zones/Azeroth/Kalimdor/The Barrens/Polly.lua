--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Polly_OnCombat(Unit, Event)
	Unit:RegisterEvent("Polly_Stealth", 1000, 1)
	Unit:RegisterEvent("Polly_SummonPollyJr", 4000, 1)
end

function Polly_Stealth(Unit, Event) 
	Unit:CastSpell(8822) 
end

function Polly_SummonPollyJr(Unit, Event) 
	Unit:CastSpell(9998) 
end

function Polly_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Polly_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Polly_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(7167, 1, "Polly_OnCombat")
RegisterUnitEvent(7167, 2, "Polly_OnLeaveCombat")
RegisterUnitEvent(7167, 3, "Polly_OnKilledTarget")
RegisterUnitEvent(7167, 4, "Polly_OnDied")