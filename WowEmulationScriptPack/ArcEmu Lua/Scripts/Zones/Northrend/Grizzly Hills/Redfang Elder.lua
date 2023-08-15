--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function RedfangElder_OnCombat(Unit, Event)
Unit:RegisterEvent("RedfangElder_ChainHeal", 12000, 0)
Unit:RegisterEvent("RedfangElder_Hurricane", 10000, 0)
end

function RedfangElder_ChainHeal(Unit, Event) 
Unit:CastSpell(14900) 
end

function RedfangElder_Hurricane(Unit, Event) 
Unit:CastSpell(32717) 
end

function RedfangElder_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RedfangElder_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RedfangElder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26436, 1, "RedfangElder_OnCombat")
RegisterUnitEvent(26436, 2, "RedfangElder_OnLeaveCombat")
RegisterUnitEvent(26436, 3, "RedfangElder_OnKilledTarget")
RegisterUnitEvent(26436, 4, "RedfangElder_OnDied")