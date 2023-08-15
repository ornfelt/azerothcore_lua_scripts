--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function FrostpawShaman_OnCombat(Unit, Event)
Unit:RegisterEvent("FrostpawShaman_ChainLightning", 6000, 0)
Unit:RegisterEvent("FrostpawShaman_LesserHealingWave", 13000, 0)
end

function FrostpawShaman_ChainLightning(Unit, Event) 
Unit:FullCastSpellOnTarget(12058, Unit:GetMainTank()) 
end

function FrostpawShaman_LesserHealingWave(Unit, Event) 
Unit:CastSpell(25420) 
end

function FrostpawShaman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FrostpawShaman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FrostpawShaman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26428, 1, "FrostpawShaman_OnCombat")
RegisterUnitEvent(26428, 2, "FrostpawShaman_OnLeaveCombat")
RegisterUnitEvent(26428, 3, "FrostpawShaman_OnKilledTarget")
RegisterUnitEvent(26428, 4, "FrostpawShaman_OnDied")