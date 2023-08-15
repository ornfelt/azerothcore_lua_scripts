--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TaunkaleBrave_OnCombat(Unit, Event)
Unit:RegisterEvent("TaunkaleBrave_GroundSlam", 7000, 0)
end

function TaunkaleBrave_GroundSlam(Unit, Event) 
Unit:CastSpell(52058) 
end

function TaunkaleBrave_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TaunkaleBrave_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TaunkaleBrave_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26157, 1, "TaunkaleBrave_OnCombat")
RegisterUnitEvent(26157, 2, "TaunkaleBrave_OnLeaveCombat")
RegisterUnitEvent(26157, 3, "TaunkaleBrave_OnKilledTarget")
RegisterUnitEvent(26157, 4, "TaunkaleBrave_OnDied")