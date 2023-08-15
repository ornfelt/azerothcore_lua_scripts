--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WindTraderMufah_OnCombat(Unit, Event)
Unit:RegisterEvent("WindTraderMufah_Typhoon", 4000, 1)
end

function WindTraderMufah_Typhoon(Unit, Event) 
Unit:CastSpell(51817) 
end

function WindTraderMufah_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WindTraderMufah_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WindTraderMufah_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26496, 1, "WindTraderMufah_OnCombat")
RegisterUnitEvent(26496, 2, "WindTraderMufah_OnLeaveCombat")
RegisterUnitEvent(26496, 3, "WindTraderMufah_OnKilledTarget")
RegisterUnitEvent(26496, 4, "WindTraderMufah_OnDied")