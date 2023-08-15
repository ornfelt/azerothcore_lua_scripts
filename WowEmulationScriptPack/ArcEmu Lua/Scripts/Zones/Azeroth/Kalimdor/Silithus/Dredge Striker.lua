--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DredgeStriker_OnCombat(Unit, Event)
	Unit:RegisterEvent("DredgeStriker_Charge", 8000, 0)
end

function DredgeStriker_Charge(Unit, Event) 
	Unit:FullCastSpellOnTarget(22911, 	Unit:GetRandomPlayer(0)) 
end

function DredgeStriker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DredgeStriker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function DredgeStriker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11740, 1, "DredgeStriker_OnCombat")
RegisterUnitEvent(11740, 2, "DredgeStriker_OnLeaveCombat")
RegisterUnitEvent(11740, 3, "DredgeStriker_OnKilledTarget")
RegisterUnitEvent(11740, 4, "DredgeStriker_OnDied")