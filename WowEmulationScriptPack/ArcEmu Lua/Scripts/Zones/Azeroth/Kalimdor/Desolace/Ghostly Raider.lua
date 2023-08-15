--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GhostlyRaider_OnCombat(Unit, Event)
	Unit:RegisterEvent("GhostlyRaider_ConcussiveShot", 10000, 0)
	Unit:RegisterEvent("GhostlyRaider_Net", 11000, 0)
	Unit:RegisterEvent("GhostlyRaider_Shoot", 6000, 0)
end

function GhostlyRaider_ConcussiveShot(Unit, Event) 
	Unit:FullCastSpellOnTarget(17174, 	Unit:GetMainTank()) 
end

function GhostlyRaider_Net(Unit, Event) 
	Unit:FullCastSpellOnTarget(5533, 	Unit:GetMainTank()) 
end

function GhostlyRaider_Shoot(Unit, Event) 
	Unit:FullCastSpellOnTarget(6660, 	Unit:GetMainTank()) 
end

function GhostlyRaider_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GhostlyRaider_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function GhostlyRaider_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11686, 1, "GhostlyRaider_OnCombat")
RegisterUnitEvent(11686, 2, "GhostlyRaider_OnLeaveCombat")
RegisterUnitEvent(11686, 3, "GhostlyRaider_OnKilledTarget")
RegisterUnitEvent(11686, 4, "GhostlyRaider_OnDied")