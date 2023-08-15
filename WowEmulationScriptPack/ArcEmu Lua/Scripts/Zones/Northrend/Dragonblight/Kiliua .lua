--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function KoltiraDeathweaver_OnCombat(Unit, Event)
Unit:RegisterEvent("KoltiraDeathweaver_WorldofShadows", 5000, 1)
end

function KoltiraDeathweaver_WorldofShadows(Unit, Event) 
Unit:CastSpell(47740) 
end

function KoltiraDeathweaver_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function KoltiraDeathweaver_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function KoltiraDeathweaver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26581, 1, "KoltiraDeathweaver_OnCombat")
RegisterUnitEvent(26581, 2, "KoltiraDeathweaver_OnLeaveCombat")
RegisterUnitEvent(26581, 3, "KoltiraDeathweaver_OnKilledTarget")
RegisterUnitEvent(26581, 4, "KoltiraDeathweaver_OnDied")