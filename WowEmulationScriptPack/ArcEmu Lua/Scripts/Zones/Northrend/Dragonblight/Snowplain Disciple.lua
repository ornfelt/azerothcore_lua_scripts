--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SnowplainDisciple_OnCombat(Unit, Event)
Unit:RegisterEvent("SnowplainDisciple_Frostbolt", 6500, 0)
Unit:RegisterEvent("SnowplainDisciple_RenewingBeam", 11000, 0)
end

function SnowplainDisciple_Frostbolt(Unit, Event) 
Unit:FullCastSpellOnTarget(61730, Unit:GetMainTank()) 
end

function SnowplainDisciple_RenewingBeam(Unit, Event) 
Unit:CastSpell(52011) 
end

function SnowplainDisciple_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SnowplainDisciple_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SnowplainDisciple_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26705, 1, "SnowplainDisciple_OnCombat")
RegisterUnitEvent(26705, 2, "SnowplainDisciple_OnLeaveCombat")
RegisterUnitEvent(26705, 3, "SnowplainDisciple_OnKilledTarget")
RegisterUnitEvent(26705, 4, "SnowplainDisciple_OnDied")