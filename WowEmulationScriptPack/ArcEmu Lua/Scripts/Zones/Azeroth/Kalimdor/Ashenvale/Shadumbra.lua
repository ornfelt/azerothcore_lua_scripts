--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Shadumbra_OnCombat(Unit, Event)
	Unit:RegisterEvent("Shadumbra_Rend", 10000, 0)
end

function Shadumbra_Rend(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(13445, 	pUnit:GetMainTank()) 
end

function Shadumbra_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Shadumbra_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(12677, 1, "Shadumbra_OnCombat")
RegisterUnitEvent(12677, 2, "Shadumbra_OnLeaveCombat")
RegisterUnitEvent(12677, 4, "Shadumbra_OnDied")