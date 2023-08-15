--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HatefuryTrickster_OnCombat(Unit, Event)
	Unit:RegisterEvent("HatefuryTrickster_Enrage", 10000, 1)
	Unit:RegisterEvent("HatefuryTrickster_Poison", 8000, 1)
end

function HatefuryTrickster_Enrage(Unit, Event) 
	Unit:CastSpell(8599) 
end

function HatefuryTrickster_Poison(Unit, Event) 
	Unit:FullCastSpellOnTarget(744, 	Unit:GetMainTank()) 
end

function HatefuryTrickster_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HatefuryTrickster_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HatefuryTrickster_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4671, 1, "HatefuryTrickster_OnCombat")
RegisterUnitEvent(4671, 2, "HatefuryTrickster_OnLeaveCombat")
RegisterUnitEvent(4671, 3, "HatefuryTrickster_OnKilledTarget")
RegisterUnitEvent(4671, 4, "HatefuryTrickster_OnDied")