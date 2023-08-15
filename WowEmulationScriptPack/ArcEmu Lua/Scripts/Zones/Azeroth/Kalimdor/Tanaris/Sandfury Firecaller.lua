--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SandfuryFirecaller_OnCombat(Unit, Event)
	Unit:RegisterEvent("SandfuryFirecaller_Fireball", 5000, 0)
end

function SandfuryFirecaller_Fireball(Unit, Event) 
	Unit:FullCastSpellOnTarget(20823, 	Unit:GetMainTank()) 
end

function SandfuryFirecaller_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SandfuryFirecaller_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function SandfuryFirecaller_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5647, 1, "SandfuryFirecaller_OnCombat")
RegisterUnitEvent(5647, 2, "SandfuryFirecaller_OnLeaveCombat")
RegisterUnitEvent(5647, 3, "SandfuryFirecaller_OnKilledTarget")
RegisterUnitEvent(5647, 4, "SandfuryFirecaller_OnDied")