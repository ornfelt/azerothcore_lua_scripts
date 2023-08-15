--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Tazan_OnCombat(Unit, Event)
	Unit:RegisterEvent("Tazan_Backhand", 8000, 0)
end

function Tazan_Backhand(Unit, Event) 
	Unit:FullCastSpellOnTarget(6253, 	Unit:GetMainTank()) 
end

function Tazan_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Tazan_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Tazan_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(6494, 1, "Tazan_OnCombat")
RegisterUnitEvent(6494, 2, "Tazan_OnLeaveCombat")
RegisterUnitEvent(6494, 3, "Tazan_OnKilledTarget")
RegisterUnitEvent(6494, 4, "Tazan_OnDied")