--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SummonedFelhunter_OnCombat(Unit, Event)
	Unit:RegisterEvent("SummonedFelhunter_ManaBurn", 6000, 0)
end

function SummonedFelhunter_ManaBurn(Unit, Event) 
	Unit:FullCastSpellOnTarget(2691, 	Unit:GetRandomPlayer(4)) 
end

function SummonedFelhunter_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SummonedFelhunter_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function SummonedFelhunter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(6268, 1, "SummonedFelhunter_OnCombat")
RegisterUnitEvent(6268, 2, "SummonedFelhunter_OnLeaveCombat")
RegisterUnitEvent(6268, 3, "SummonedFelhunter_OnKilledTarget")
RegisterUnitEvent(6268, 4, "SummonedFelhunter_OnDied")