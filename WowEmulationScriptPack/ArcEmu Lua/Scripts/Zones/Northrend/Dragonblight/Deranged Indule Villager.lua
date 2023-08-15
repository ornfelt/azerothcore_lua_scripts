--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DerangedInduleVillager_OnCombat(Unit, Event)
Unit:RegisterEvent("DerangedInduleVillager_DerangedTantrum", 7000, 0)
end

function DerangedInduleVillager_DerangedTantrum(Unit, Event) 
Unit:CastSpell(51782) 
end

function DerangedInduleVillager_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DerangedInduleVillager_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DerangedInduleVillager_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26411, 1, "DerangedInduleVillager_OnCombat")
RegisterUnitEvent(26411, 2, "DerangedInduleVillager_OnLeaveCombat")
RegisterUnitEvent(26411, 3, "DerangedInduleVillager_OnKilledTarget")
RegisterUnitEvent(26411, 4, "DerangedInduleVillager_OnDied")