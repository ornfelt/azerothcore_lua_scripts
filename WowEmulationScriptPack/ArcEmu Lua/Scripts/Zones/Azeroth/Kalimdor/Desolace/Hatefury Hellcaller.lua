--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HatefuryHellcaller_OnCombat(Unit, Event)
	Unit:RegisterEvent("HatefuryHellcaller_Enrage", 10000, 1)
	Unit:RegisterEvent("HatefuryHellcaller_Immolate", 5000, 1)
	Unit:RegisterEvent("HatefuryHellcaller_RainofFire", 11000, 0)
end

function HatefuryHellcaller_Enrage(Unit, Event) 
	Unit:CastSpell(8599) 
end

function HatefuryHellcaller_Immolate(Unit, Event) 
	Unit:FullCastSpellOnTarget(1094, 	Unit:GetMainTank()) 
end

function HatefuryHellcaller_RainofFire(Unit, Event) 
	Unit:CastSpell(39273) 
end

function HatefuryHellcaller_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HatefuryHellcaller_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HatefuryHellcaller_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4675, 1, "HatefuryHellcaller_OnCombat")
RegisterUnitEvent(4675, 2, "HatefuryHellcaller_OnLeaveCombat")
RegisterUnitEvent(4675, 3, "HatefuryHellcaller_OnKilledTarget")
RegisterUnitEvent(4675, 4, "HatefuryHellcaller_OnDied")