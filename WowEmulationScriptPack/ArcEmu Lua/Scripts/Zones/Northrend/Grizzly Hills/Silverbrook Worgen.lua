--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SilverbrookWorgen_OnCombat(Unit, Event)
Unit:RegisterEvent("SilverbrookWorgen_Dash", 10000, 0)
end

function SilverbrookWorgen_Dash(Unit, Event) 
Unit:CastSpell(36589) 
end

function SilverbrookWorgen_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SilverbrookWorgen_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SilverbrookWorgen_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(47417, 1, "SilverbrookWorgen_OnCombat")
RegisterUnitEvent(47417, 2, "SilverbrookWorgen_OnLeaveCombat")
RegisterUnitEvent(47417, 3, "SilverbrookWorgen_OnKilledTarget")
RegisterUnitEvent(47417, 4, "SilverbrookWorgen_OnDied")