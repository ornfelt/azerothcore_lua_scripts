--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function IronThaneArgrum_OnCombat(Unit, Event)
Unit:RegisterEvent("IronThaneArgrum_CallLightning", 6000, 0)
Unit:RegisterEvent("IronThaneArgrum_LightningShield", 4000, 0)
end

function IronThaneArgrum_CallLightning(Unit, Event) 
Unit:FullCastSpellOnTarget(32018, Unit:GetMainTank()) 
end

function IronThaneArgrum_LightningShield(Unit, Event) 
Unit:CastSpell(52651) 
end

function IronThaneArgrum_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IronThaneArgrum_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IronThaneArgrum_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26348, 1, "IronThaneArgrum_OnCombat")
RegisterUnitEvent(26348, 2, "IronThaneArgrum_OnLeaveCombat")
RegisterUnitEvent(26348, 3, "IronThaneArgrum_OnKilledTarget")
RegisterUnitEvent(26348, 4, "IronThaneArgrum_OnDied")