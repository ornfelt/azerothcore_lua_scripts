--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SinoktheShadowrager_OnCombat(Unit, Event)
Unit:RegisterEvent("SinoktheShadowrager_BlinkStrike", 6000, 0)
Unit:RegisterEvent("SinoktheShadowrager_RagingShadows", 8000, 0)
end

function SinoktheShadowrager_BlinkStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(49961, Unit:GetMainTank()) 
end

function SinoktheShadowrager_RagingShadows(Unit, Event) 
Unit:CastSpell(51622) 
end

function SinoktheShadowrager_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SinoktheShadowrager_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SinoktheShadowrager_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26771, 1, "SinoktheShadowrager_OnCombat")
RegisterUnitEvent(26771, 2, "SinoktheShadowrager_OnLeaveCombat")
RegisterUnitEvent(26771, 3, "SinoktheShadowrager_OnKilledTarget")
RegisterUnitEvent(26771, 4, "SinoktheShadowrager_OnDied")