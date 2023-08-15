--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DredgeCrusher_OnCombat(Unit, Event)
	Unit:RegisterEvent("DredgeCrusher_Lash", 8000, 0)
end

function DredgeCrusher_Lash(Unit, Event) 
	Unit:FullCastSpellOnTarget(6607, 	Unit:GetMainTank()) 
end

function DredgeCrusher_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DredgeCrusher_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function DredgeCrusher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11741, 1, "DredgeCrusher_OnCombat")
RegisterUnitEvent(11741, 2, "DredgeCrusher_OnLeaveCombat")
RegisterUnitEvent(11741, 3, "DredgeCrusher_OnKilledTarget")
RegisterUnitEvent(11741, 4, "DredgeCrusher_OnDied")