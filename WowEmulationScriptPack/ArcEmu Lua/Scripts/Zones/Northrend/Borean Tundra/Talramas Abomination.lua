--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TalramasAbomination_OnCombat(Unit, Event)
Unit:RegisterEvent("TalramasAbomination_PlagueCloud", 2000, 2)
end

function TalramasAbomination_PlagueCloud(Unit, Event) 
Unit:CastSpell(50366) 
end

function TalramasAbomination_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TalramasAbomination_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TalramasAbomination_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25684, 1, "TalramasAbomination_OnCombat")
RegisterUnitEvent(25684, 2, "TalramasAbomination_OnLeaveCombat")
RegisterUnitEvent(25684, 3, "TalramasAbomination_OnKilledTarget")
RegisterUnitEvent(25684, 4, "TalramasAbomination_OnDied")