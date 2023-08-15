--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WastesTaskmaster_OnCombat(Unit, Event)
Unit:RegisterEvent("WastesTaskmaster_ShadowNova", 5000, 0)
Unit:RegisterEvent("WastesTaskmaster_ShadowShock", 6000, 0)
end

function WastesTaskmaster_ShadowNova(Unit, Event) 
Unit:CastSpell(32712) 
end

function WastesTaskmaster_ShadowShock(Unit, Event) 
Unit:FullCastSpellOnTarget(16583, Unit:GetMainTank()) 
end

function WastesTaskmaster_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WastesTaskmaster_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WastesTaskmaster_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26493, 1, "WastesTaskmaster_OnCombat")
RegisterUnitEvent(26493, 2, "WastesTaskmaster_OnLeaveCombat")
RegisterUnitEvent(26493, 3, "WastesTaskmaster_OnKilledTarget")
RegisterUnitEvent(26493, 4, "WastesTaskmaster_OnDied")