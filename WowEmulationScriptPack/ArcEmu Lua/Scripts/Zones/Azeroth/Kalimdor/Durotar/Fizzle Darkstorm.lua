--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function FizzleDarkstorm_OnCombat(Unit, Event)
	Unit:RegisterEvent("FizzleDarkstorm_SoulSiphon", 13000, 0)
	Unit:RegisterEvent("FizzleDarkstorm_ShadowBolt", 8000, 0)
	Unit:RegisterEvent("FizzleDarkstorm_SummonImp", 1000, 1)
end

function FizzleDarkstorm_SummonImp(Unit, Event) 
	Unit:CastSpell(11939) 
end

function FizzleDarkstorm_SoulSiphon(Unit, Event) 
	Unit:FullCastSpellOnTarget(7290, 	Unit:GetMainTank()) 
end

function FizzleDarkstorm_ShadowBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(20791, 	Unit:GetMainTank()) 
end

function FizzleDarkstorm_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function FizzleDarkstorm_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function FizzleDarkstorm_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3203, 1, "FizzleDarkstorm_OnCombat")
RegisterUnitEvent(3203, 2, "FizzleDarkstorm_OnLeaveCombat")
RegisterUnitEvent(3203, 3, "FizzleDarkstorm_OnKilledTarget")
RegisterUnitEvent(3203, 4, "FizzleDarkstorm_OnDied")