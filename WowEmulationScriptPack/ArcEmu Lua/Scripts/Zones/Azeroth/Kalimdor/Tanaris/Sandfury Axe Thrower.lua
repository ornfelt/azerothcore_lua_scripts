--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SandfuryAxeThrower_OnCombat(Unit, Event)
	Unit:RegisterEvent("SandfuryAxeThrower_Throw", 4000, 0)
end

function SandfuryAxeThrower_Throw(Unit, Event) 
	Unit:FullCastSpellOnTarget(10277, 	Unit:GetMainTank()) 
end

function SandfuryAxeThrower_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SandfuryAxeThrower_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function SandfuryAxeThrower_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5646, 1, "SandfuryAxeThrower_OnCombat")
RegisterUnitEvent(5646, 2, "SandfuryAxeThrower_OnLeaveCombat")
RegisterUnitEvent(5646, 3, "SandfuryAxeThrower_OnKilledTarget")
RegisterUnitEvent(5646, 4, "SandfuryAxeThrower_OnDied")