--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Akkrilus_OnCombat(Unit, Event)
	Unit:RegisterEvent("Akkrilus_FireShieldII", 1000, 1)
	Unit:RegisterEvent("Akkrilus_Immolate", 7000, 0)
end

function Akkrilus_FireShieldII(pUnit, Event) 
	pUnit:CastSpell(184) 
end

function Akkrilus_Immolate(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(1094, 	pUnit:GetMainTank()) 
end

function Akkrilus_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Akkrilus_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3773, 1, "Akkrilus_OnCombat")
RegisterUnitEvent(3773, 2, "Akkrilus_OnLeaveCombat")
RegisterUnitEvent(3773, 4, "Akkrilus_OnDied")