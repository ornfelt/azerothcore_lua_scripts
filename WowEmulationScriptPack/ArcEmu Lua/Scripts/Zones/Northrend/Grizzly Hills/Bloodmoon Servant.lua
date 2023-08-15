--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BloodmoonServant_OnCombat(Unit, Event)
Unit:RegisterEvent("BloodmoonServant_Enrage", 10000, 0)
end

function BloodmoonServant_Enrage(Unit, Event) 
Unit:CastSpell(32714) 
end

function BloodmoonServant_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BloodmoonServant_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BloodmoonServant_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(29082, 1, "BloodmoonServant_OnCombat")
RegisterUnitEvent(29082, 2, "BloodmoonServant_OnLeaveCombat")
RegisterUnitEvent(29082, 3, "BloodmoonServant_OnKilledTarget")
RegisterUnitEvent(29082, 4, "BloodmoonServant_OnDied")