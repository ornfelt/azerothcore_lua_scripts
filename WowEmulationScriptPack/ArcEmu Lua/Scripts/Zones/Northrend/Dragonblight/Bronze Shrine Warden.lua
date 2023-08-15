--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BronzeShrineWarden_OnCombat(Unit, Event)
Unit:RegisterEvent("BronzeShrineWarden_SandBreath", 8000, 0)
Unit:RegisterEvent("BronzeShrineWarden_StopTime", 15000, 0)
end

function BronzeShrineWarden_SandBreath(Unit, Event) 
Unit:CastSpell(20716) 
end

function BronzeShrineWarden_StopTime(Unit, Event) 
Unit:CastSpell(60077) 
end

function BronzeShrineWarden_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BronzeShrineWarden_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BronzeShrineWarden_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26277, 1, "BronzeShrineWarden_OnCombat")
RegisterUnitEvent(26277, 2, "BronzeShrineWarden_OnLeaveCombat")
RegisterUnitEvent(26277, 3, "BronzeShrineWarden_OnKilledTarget")
RegisterUnitEvent(26277, 4, "BronzeShrineWarden_OnDied")