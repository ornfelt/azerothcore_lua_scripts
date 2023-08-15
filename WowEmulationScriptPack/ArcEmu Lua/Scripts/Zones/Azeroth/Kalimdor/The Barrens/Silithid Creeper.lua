--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SilithidCreeper_OnCombat(Unit, Event)
	Unit:RegisterEvent("SilithidCreeper_SilithidCreeperEgg", 4000, 1)
end

function SilithidCreeper_SilithidCreeperEgg(Unit, Event) 
	Unit:CastSpell(6587) 
end

function SilithidCreeper_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SilithidCreeper_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function SilithidCreeper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3250, 1, "SilithidCreeper_OnCombat")
RegisterUnitEvent(3250, 2, "SilithidCreeper_OnLeaveCombat")
RegisterUnitEvent(3250, 3, "SilithidCreeper_OnKilledTarget")
RegisterUnitEvent(3250, 4, "SilithidCreeper_OnDied")