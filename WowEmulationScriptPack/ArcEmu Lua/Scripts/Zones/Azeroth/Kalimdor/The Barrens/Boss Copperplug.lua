--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BossCopperplug_OnCombat(Unit, Event)
	Unit:RegisterEvent("BossCopperplug_Bom", 8000, 0)
	Unit:RegisterEvent("BossCopperplug_Net", 10000, 0)
end

function BossCopperplug_Bom(Unit, Event) 
	Unit:CastSpell(9143) 
end

function BossCopperplug_Net(Unit, Event) 
	Unit:FullCastSpellOnTarget(6533, 	Unit:GetMainTank()) 
end

function BossCopperplug_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BossCopperplug_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function BossCopperplug_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(9336, 1, "BossCopperplug_OnCombat")
RegisterUnitEvent(9336, 2, "BossCopperplug_OnLeaveCombat")
RegisterUnitEvent(9336, 3, "BossCopperplug_OnKilledTarget")
RegisterUnitEvent(9336, 4, "BossCopperplug_OnDied")