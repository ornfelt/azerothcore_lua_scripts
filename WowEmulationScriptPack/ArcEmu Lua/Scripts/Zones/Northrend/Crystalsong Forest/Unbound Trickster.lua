--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function UnboundTrickster_OnCombat(Unit, Event)
Unit:RegisterEvent("UnboundTrickster_FireBlast", 6000, 0)
Unit:RegisterEvent("UnboundTrickster_Ignite", 8000, 0)
end

function UnboundTrickster_FireBlast(Unit, Event) 
Unit:FullCastSpellOnTarget(13341, Unit:GetMainTank()) 
end

function UnboundTrickster_Ignite(Unit, Event) 
Unit:FullCastSpellOnTarget(58438, Unit:GetMainTank()) 
end

function UnboundTrickster_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function UnboundTrickster_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function UnboundTrickster_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30856, 1, "UnboundTrickster_OnCombat")
RegisterUnitEvent(30856, 2, "UnboundTrickster_OnLeaveCombat")
RegisterUnitEvent(30856, 3, "UnboundTrickster_OnKilledTarget")
RegisterUnitEvent(30856, 4, "UnboundTrickster_OnDied")