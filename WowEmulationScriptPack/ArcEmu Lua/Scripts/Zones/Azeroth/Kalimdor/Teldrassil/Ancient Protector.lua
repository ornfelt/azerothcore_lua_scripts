--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AncientProtector_OnCombat(Unit, Event)
	Unit:RegisterEvent("AncientProtector_EntanglingRoots", 10000, 0)
	Unit:RegisterEvent("AncientProtector_WarStomp", 6000, 0)
end

function AncientProtector_EntanglingRoots(Unit, Event) 
	Unit:FullCastSpellOnTarget(11922, 	Unit:GetRandomPlayer(0)) 
end

function AncientProtector_WarStomp(Unit, Event) 
	Unit:CastSpell(45) 
end

function AncientProtector_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function AncientProtector_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function AncientProtector_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2041, 1, "AncientProtector_OnCombat")
RegisterUnitEvent(2041, 2, "AncientProtector_OnLeaveCombat")
RegisterUnitEvent(2041, 3, "AncientProtector_OnKilledTarget")
RegisterUnitEvent(2041, 4, "AncientProtector_OnDied")