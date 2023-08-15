--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DukeVallenhal_OnCombat(Unit, Event)
Unit:RegisterEvent("DukeVallenhal_BloodPresence", 1000, 1)
Unit:RegisterEvent("DukeVallenhal_Bloodworm", 4000, 1)
end

function DukeVallenhal_BloodPresence(Unit, Event) 
Unit:CastSpell(50689) 
end

function DukeVallenhal_Bloodworm(Unit, Event) 
Unit:CastSpell(51879) 
end

function DukeVallenhal_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DukeVallenhal_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DukeVallenhal_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26926, 1, "DukeVallenhal_OnCombat")
RegisterUnitEvent(26926, 2, "DukeVallenhal_OnLeaveCombat")
RegisterUnitEvent(26926, 3, "DukeVallenhal_OnKilledTarget")
RegisterUnitEvent(26926, 4, "DukeVallenhal_OnDied")