--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function InduleMystic_OnCombat(Unit, Event)
Unit:RegisterEvent("InduleMystic_MysticalBolt", 6000, 0)
end

function InduleMystic_MysticalBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(51787, Unit:GetMainTank()) 
end

function InduleMystic_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InduleMystic_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InduleMystic_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26336, 1, "InduleMystic_OnCombat")
RegisterUnitEvent(26336, 2, "InduleMystic_OnLeaveCombat")
RegisterUnitEvent(26336, 3, "InduleMystic_OnKilledTarget")
RegisterUnitEvent(26336, 4, "InduleMystic_OnDied")