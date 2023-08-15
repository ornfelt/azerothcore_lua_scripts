--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MammothCalf_OnCombat(Unit, Event)
Unit:RegisterEvent("MammothCalf_Trample", 6000, 0)
end

function MammothCalf_Trample(Unit, Event) 
Unit:CastSpell(15550) 
end

function MammothCalf_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MammothCalf_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MammothCalf_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24613, 1, "MammothCalf_OnCombat")
RegisterUnitEvent(24613, 2, "MammothCalf_OnLeaveCombat")
RegisterUnitEvent(24613, 3, "MammothCalf_OnKilledTarget")
RegisterUnitEvent(24613, 4, "MammothCalf_OnDied")