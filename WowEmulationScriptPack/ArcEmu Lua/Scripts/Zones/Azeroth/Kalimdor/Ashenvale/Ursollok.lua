--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Ursollok_OnCombat(Unit, Event)
	Unit:RegisterEvent("Ursollok_Maul", 5000, 0)
end

function Ursollok_Maul(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(17156, 	pUnit:GetMainTank()) 
end

function Ursollok_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Ursollok_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(12037, 1, "Ursollok_OnCombat")
RegisterUnitEvent(12037, 2, "Ursollok_OnLeaveCombat")
RegisterUnitEvent(12037, 3, "Ursollok_OnKilledTarget")
RegisterUnitEvent(12037, 4, "Ursollok_OnDied")