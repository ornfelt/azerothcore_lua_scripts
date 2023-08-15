--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WastewanderRogue_OnCombat(Unit, Event)
	Unit:RegisterEvent("WastewanderRogue_Backstab", 5000, 0)
end

function WastewanderRogue_Backstab(Unit, Event) 
	Unit:FullCastSpellOnTarget(8721, 	Unit:GetMainTank()) 
end

function WastewanderRogue_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WastewanderRogue_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function WastewanderRogue_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5615, 1, "WastewanderRogue_OnCombat")
RegisterUnitEvent(5615, 2, "WastewanderRogue_OnLeaveCombat")
RegisterUnitEvent(5615, 3, "WastewanderRogue_OnKilledTarget")
RegisterUnitEvent(5615, 4, "WastewanderRogue_OnDied")