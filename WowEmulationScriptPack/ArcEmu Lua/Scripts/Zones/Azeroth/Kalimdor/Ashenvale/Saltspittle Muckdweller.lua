--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SaltspittleMuckdweller_OnCombat(Unit, Event)
	Unit:RegisterEvent("SaltspittleMuckdweller_Throw", 6000, 0)
end

function SaltspittleMuckdweller_Throw(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(10277, 	pUnit:GetMainTank()) 
end

function SaltspittleMuckdweller_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SaltspittleMuckdweller_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3740, 1, "SaltspittleMuckdweller_OnCombat")
RegisterUnitEvent(3740, 2, "SaltspittleMuckdweller_OnLeaveCombat")
RegisterUnitEvent(3740, 4, "SaltspittleMuckdweller_OnDied")