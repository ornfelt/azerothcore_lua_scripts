--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Rockfang_OnCombat(Unit, Event)
Unit:RegisterEvent("Rockfang_ChillingHowl", 10000, 0)
end

function Rockfang_ChillingHowl(Unit, Event) 
Unit:CastSpell(32918) 
end

function Rockfang_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Rockfang_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Rockfang_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25774, 1, "Rockfang_OnCombat")
RegisterUnitEvent(25774, 2, "Rockfang_OnLeaveCombat")
RegisterUnitEvent(25774, 3, "Rockfang_OnKilledTarget")
RegisterUnitEvent(25774, 4, "Rockfang_OnDied")