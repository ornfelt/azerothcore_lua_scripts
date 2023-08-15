--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HighCultistZangus_OnCombat(Unit, Event)
Unit:RegisterEvent("HighCultistZangus_ShadowBolt", 7000, 0)
Unit:RegisterEvent("HighCultistZangus_Zeal", 2000, 1)
end

function HighCultistZangus_ShadowBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(9613, Unit:GetMainTank()) 
end

function HighCultistZangus_Zeal(Unit, Event) 
Unit:CastSpell(51605) 
end

function HighCultistZangus_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function HighCultistZangus_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function HighCultistZangus_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26655, 1, "HighCultistZangus_OnCombat")
RegisterUnitEvent(26655, 2, "HighCultistZangus_OnLeaveCombat")
RegisterUnitEvent(26655, 3, "HighCultistZangus_OnKilledTarget")
RegisterUnitEvent(26655, 4, "HighCultistZangus_OnDied")