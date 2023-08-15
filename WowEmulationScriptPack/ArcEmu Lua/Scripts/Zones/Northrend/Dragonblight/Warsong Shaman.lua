--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WarsongShaman_OnCombat(Unit, Event)
Unit:RegisterEvent("WarsongShaman_ChainHeal", 16000, 0)
Unit:RegisterEvent("WarsongShaman_ChainLightning", 9000, 0)
Unit:RegisterEvent("WarsongShaman_EarthShock", 12000, 0)
Unit:RegisterEvent("WarsongShaman_LesserHealingWave", 20000, 0)
Unit:RegisterEvent("WarsongShaman_WaterShield", 4000, 1)
end

function WarsongShaman_ChainHeal(Unit, Event) 
Unit:CastSpell(16367) 
end

function WarsongShaman_ChainLightning(Unit, Event) 
Unit:FullCastSpellOnTarget(39945, Unit:GetMainTank()) 
end

function WarsongShaman_EarthShock(Unit, Event) 
Unit:FullCastSpellOnTarget(25025, Unit:GetMainTank()) 
end

function WarsongShaman_LesserHealingWave(Unit, Event) 
Unit:CastSpell(49309) 
end

function WarsongShaman_WaterShield(Unit, Event) 
Unit:CastSpell(34827) 
end

function WarsongShaman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WarsongShaman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WarsongShaman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27678, 1, "WarsongShaman_OnCombat")
RegisterUnitEvent(27678, 2, "WarsongShaman_OnLeaveCombat")
RegisterUnitEvent(27678, 3, "WarsongShaman_OnKilledTarget")
RegisterUnitEvent(27678, 4, "WarsongShaman_OnDied")