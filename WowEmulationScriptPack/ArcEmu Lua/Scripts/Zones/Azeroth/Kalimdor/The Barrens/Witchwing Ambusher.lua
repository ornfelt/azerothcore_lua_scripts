--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WitchwingAmbusher_OnCombat(Unit, Event)
	Unit:RegisterEvent("WitchwingAmbusher_ExploitWeakness", 5000, 0)
end

function WitchwingAmbusher_ExploitWeakness(Unit, Event) 
	Unit:FullCastSpellOnTarget(6595, 	Unit:GetMainTank()) 
end

function WitchwingAmbusher_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WitchwingAmbusher_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function WitchwingAmbusher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3279, 1, "WitchwingAmbusher_OnCombat")
RegisterUnitEvent(3279, 2, "WitchwingAmbusher_OnLeaveCombat")
RegisterUnitEvent(3279, 3, "WitchwingAmbusher_OnKilledTarget")
RegisterUnitEvent(3279, 4, "WitchwingAmbusher_OnDied")