--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WitchwingRoguefeather_OnCombat(Unit, Event)
	Unit:RegisterEvent("WitchwingRoguefeather_ExploitWeakness", 60000, 0)
	Unit:RegisterEvent("WitchwingRoguefeather_SlowingPoison", 10000, 0)
end

function WitchwingRoguefeather_ExploitWeakness(Unit, Event) 
	Unit:FullCastSpellOnTarget(6595, 	Unit:GetMainTank()) 
end

function WitchwingRoguefeather_SlowingPoison(Unit, Event) 
	Unit:FullCastSpellOnTarget(7992, 	Unit:GetMainTank()) 
end

function WitchwingRoguefeather_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WitchwingRoguefeather_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function WitchwingRoguefeather_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3277, 1, "WitchwingRoguefeather_OnCombat")
RegisterUnitEvent(3277, 2, "WitchwingRoguefeather_OnLeaveCombat")
RegisterUnitEvent(3277, 3, "WitchwingRoguefeather_OnKilledTarget")
RegisterUnitEvent(3277, 4, "WitchwingRoguefeather_OnDied")