--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SnowfallGladeWolvar_OnCombat(Unit, Event)
Unit:RegisterEvent("SnowfallGladeWolvar_Net", 8000, 0)
Unit:RegisterEvent("SnowfallGladeWolvar_ThrowSpear", 6000, 0)
end

function SnowfallGladeWolvar_Net(Unit, Event) 
Unit:FullCastSpellOnTarget(6533, Unit:GetMainTank()) 
end

function SnowfallGladeWolvar_ThrowSpear(Unit, Event) 
Unit:FullCastSpellOnTarget(43413, Unit:GetMainTank()) 
end

function SnowfallGladeWolvar_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SnowfallGladeWolvar_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SnowfallGladeWolvar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26198, 1, "SnowfallGladeWolvar_OnCombat")
RegisterUnitEvent(26198, 2, "SnowfallGladeWolvar_OnLeaveCombat")
RegisterUnitEvent(26198, 3, "SnowfallGladeWolvar_OnKilledTarget")
RegisterUnitEvent(26198, 4, "SnowfallGladeWolvar_OnDied")