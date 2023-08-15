--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function HexedTroll_OnCombat(Unit, Event)
	Unit:RegisterEvent("HexedTroll_Inmolate", 8000, 0)
end

function HexedTroll_Inmolate(Unit, Event) 
	Unit:FullCastSpellOnTarget(348, 	Unit:GetMainTank()) 
end

function HexedTroll_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HexedTroll_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HexedTroll_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3207, 1, "HexedTroll_OnCombat")
RegisterUnitEvent(3207, 2, "HexedTroll_OnLeaveCombat")
RegisterUnitEvent(3207, 3, "HexedTroll_OnKilledTarget")
RegisterUnitEvent(3207, 4, "HexedTroll_OnDied")