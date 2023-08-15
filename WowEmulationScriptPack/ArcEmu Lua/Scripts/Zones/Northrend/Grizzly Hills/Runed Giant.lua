--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function RunedGiant_OnCombat(Unit, Event)
Unit:RegisterEvent("RunedGiant_RuneFist", 3000, 1)
Unit:RegisterEvent("RunedGiant_Stomp", 11000, 0)
end

function RunedGiant_RuneFist(Unit, Event) 
Unit:CastSpell(49717) 
end

function RunedGiant_Stomp(Unit, Event) 
Unit:CastSpell(55196) 
end

function RunedGiant_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RunedGiant_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RunedGiant_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26417, 1, "RunedGiant_OnCombat")
RegisterUnitEvent(26417, 2, "RunedGiant_OnLeaveCombat")
RegisterUnitEvent(26417, 3, "RunedGiant_OnKilledTarget")
RegisterUnitEvent(26417, 4, "RunedGiant_OnDied")