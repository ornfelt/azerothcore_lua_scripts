--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WhirlingInvader_OnCombat(Unit, Event)
	Unit:RegisterEvent("WhirlingInvader_Whirlwind", 6000, 0)
end

function WhirlingInvader_Whirlwind(Unit, Event) 
	Unit:CastSpell(17207) 
end

function WhirlingInvader_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WhirlingInvader_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function WhirlingInvader_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(14455, 1, "WhirlingInvader_OnCombat")
RegisterUnitEvent(14455, 2, "WhirlingInvader_OnLeaveCombat")
RegisterUnitEvent(14455, 3, "WhirlingInvader_OnKilledTarget")
RegisterUnitEvent(14455, 4, "WhirlingInvader_OnDied")