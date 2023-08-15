--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CampOneqwahBrave_OnCombat(Unit, Event)
Unit:RegisterEvent("CampOneqwahBrave_Cleave", 8000, 0)
end

function CampOneqwahBrave_Cleave(Unit, Event) 
Unit:CastSpell(40505) 
end

function CampOneqwahBrave_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CampOneqwahBrave_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CampOneqwahBrave_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27126, 1, "CampOneqwahBrave_OnCombat")
RegisterUnitEvent(27126, 2, "CampOneqwahBrave_OnLeaveCombat")
RegisterUnitEvent(27126, 3, "CampOneqwahBrave_OnKilledTarget")
RegisterUnitEvent(27126, 4, "CampOneqwahBrave_OnDied")