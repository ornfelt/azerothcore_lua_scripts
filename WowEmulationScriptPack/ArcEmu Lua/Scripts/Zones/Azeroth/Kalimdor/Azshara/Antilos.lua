--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Antilos_OnCombat(Unit, Event)
	Unit:RegisterEvent("Antilos_Cleave", 8000, 0)
	Unit:RegisterEvent("Antilos_Rend", 10000, 0)
	Unit:RegisterEvent("Antilos_Swoop", 9000, 0)
end

function Antilos_Cleave(pUnit, Event) 
	pUnit:CastSpell(40505) 
end

function Antilos_Rend(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(13445, 	pUnit:GetMainTank()) 
end

function Antilos_Swoop(pUnit, Event) 
	pUnit:CastSpell(5708) 
end

function Antilos_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Antilos_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6648, 1, "Antilos_OnCombat")
RegisterUnitEvent(6648, 2, "Antilos_OnLeaveCombat")
RegisterUnitEvent(6648, 4, "Antilos_OnDied")