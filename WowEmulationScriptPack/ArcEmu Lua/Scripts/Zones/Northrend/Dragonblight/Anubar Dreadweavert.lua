--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function AnubarDreadweaver_OnCombat(Unit, Event)
Unit:RegisterEvent("AnubarDreadweaver_Corruption", 5000, 1)
Unit:RegisterEvent("AnubarDreadweaver_ShadowBolt", 8000, 0)
end

function AnubarDreadweaver_Corruption(Unit, Event) 
Unit:FullCastSpellOnTarget(32063, Unit:GetMainTank()) 
end

function AnubarDreadweaver_ShadowBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(9613, Unit:GetMainTank()) 
end

function AnubarDreadweaver_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AnubarDreadweaver_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AnubarDreadweaver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26413, 1, "AnubarDreadweaver_OnCombat")
RegisterUnitEvent(26413, 2, "AnubarDreadweaver_OnLeaveCombat")
RegisterUnitEvent(26413, 3, "AnubarDreadweaver_OnKilledTarget")
RegisterUnitEvent(26413, 4, "AnubarDreadweaver_OnDied")