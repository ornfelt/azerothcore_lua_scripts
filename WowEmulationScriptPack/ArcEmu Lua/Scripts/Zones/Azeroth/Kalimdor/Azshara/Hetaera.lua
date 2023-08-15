--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Hetaera_OnCombat(Unit, Event)
	Unit:RegisterEvent("Hetaera_InfectedBite", 8000, 0)
end

function Hetaera_InfectedBite(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12542, 	pUnit:GetMainTank()) 
end

function Hetaera_Thrash(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3391, 	pUnit:GetMainTank()) 
end

function Hetaera_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Hetaera_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6140, 1, "Hetaera_OnCombat")
RegisterUnitEvent(6140, 2, "Hetaera_OnLeaveCombat")
RegisterUnitEvent(6140, 4, "Hetaera_OnDied")