--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SeerWiserunner_OnCombat(Unit, Event)
Unit:RegisterEvent("SeerWiserunner_MarkoftheWild", 1000, 1)
end

function SeerWiserunner_MarkoftheWild(pUnit, Event) 
pUnit:CastSpell(1126) 
end

function SeerWiserunner_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SeerWiserunner_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SeerWiserunner_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2984, 1, "SeerWiserunner_OnCombat")
RegisterUnitEvent(2984, 2, "SeerWiserunner_OnLeaveCombat")
RegisterUnitEvent(2984, 3, "SeerWiserunner_OnKilledTarget")
RegisterUnitEvent(2984, 4, "SeerWiserunner_OnDied")