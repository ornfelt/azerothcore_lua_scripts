--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DrysnapPincer_OnCombat(Unit, Event)
	Unit:RegisterEvent("DrysnapPincer_Rend", 10000, 0)
	Unit:RegisterEvent("DrysnapPincer_SunderArmor", 6000, 0)
end

function DrysnapPincer_Rend(Unit, Event) 
	Unit:FullCastSpellOnTarget(13443, 	Unit:GetMainTank()) 
end

function DrysnapPincer_SunderArmor(pUnit, Event) 
	Unit:FullCastSpellOnTarget(13444, 	Unit:GetMainTank()) 
end

function DrysnapPincer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DrysnapPincer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(11563, 1, "DrysnapPincer_OnCombat")
RegisterUnitEvent(11563, 2, "DrysnapPincer_OnLeaveCombat")
RegisterUnitEvent(11563, 4, "DrysnapPincer_OnDied")