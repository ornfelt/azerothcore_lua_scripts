--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SilithidCreeperEgg_OnCombat(Unit, Event)
	Unit:RegisterEvent("SilithidCreeperEgg_Suicide", 20000, 1)
	Unit:RegisterEvent("SilithidCreeperEgg_SummonSilithidGrub", 4000, 1)
end

function SilithidCreeperEgg_Suicide(Unit, Event) 
	Unit:CastSpell(7) 
end

function SilithidCreeperEgg_SummonSilithidGrub(Unit, Event) 
	Unit:CastSpell(6588) 
end

function SilithidCreeperEgg_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SilithidCreeperEgg_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function SilithidCreeperEgg_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5781, 1, "SilithidCreeperEgg_OnCombat")
RegisterUnitEvent(5781, 2, "SilithidCreeperEgg_OnLeaveCombat")
RegisterUnitEvent(5781, 3, "SilithidCreeperEgg_OnKilledTarget")
RegisterUnitEvent(5781, 4, "SilithidCreeperEgg_OnDied")