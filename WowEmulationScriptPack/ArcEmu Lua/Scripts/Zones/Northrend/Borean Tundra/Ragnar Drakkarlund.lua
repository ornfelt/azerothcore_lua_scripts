--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function RagnarDrakkarlund_OnCombat(Unit, Event)
Unit:RegisterEvent("RagnarDrakkarlund_Whirlwind", 8000, 0)
end

function RagnarDrakkarlund_Whirlwind(Unit, Event) 
Unit:CastSpell(41057) 
end

function RagnarDrakkarlund_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RagnarDrakkarlund_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RagnarDrakkarlund_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26451, 1, "RagnarDrakkarlund_OnCombat")
RegisterUnitEvent(26451, 2, "RagnarDrakkarlund_OnLeaveCombat")
RegisterUnitEvent(26451, 3, "RagnarDrakkarlund_OnKilledTarget")
RegisterUnitEvent(26451, 4, "RagnarDrakkarlund_OnDied")