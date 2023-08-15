--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HatefuryFelsworn_OnCombat(Unit, Event)
	Unit:RegisterEvent("HatefuryFelsworn_Enrage", 10000, 1)
end

function HatefuryFelsworn_Enrage(Unit, Event) 
	Unit:CastSpell(8599) 
end

function HatefuryFelsworn_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HatefuryFelsworn_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HatefuryFelsworn_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4672, 1, "HatefuryFelsworn_OnCombat")
RegisterUnitEvent(4672, 2, "HatefuryFelsworn_OnLeaveCombat")
RegisterUnitEvent(4672, 3, "HatefuryFelsworn_OnKilledTarget")
RegisterUnitEvent(4672, 4, "HatefuryFelsworn_OnDied")