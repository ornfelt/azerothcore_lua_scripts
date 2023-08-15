--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GeneralGorlok_OnCombat(Unit, Event)
Unit:RegisterEvent("GeneralGorlok_BerserkerCharge", 6000, 0)
Unit:RegisterEvent("GeneralGorlok_MortalStrike", 8000, 0)
end

function GeneralGorlok_BerserkerCharge(Unit, Event) 
Unit:FullCastSpellOnTarget(16636, Unit:GetMainTank()) 
end

function GeneralGorlok_MortalStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(16856, Unit:GetMainTank()) 
end

function GeneralGorlok_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GeneralGorlok_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GeneralGorlok_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27708, 1, "GeneralGorlok_OnCombat")
RegisterUnitEvent(27708, 2, "GeneralGorlok_OnLeaveCombat")
RegisterUnitEvent(27708, 3, "GeneralGorlok_OnKilledTarget")
RegisterUnitEvent(27708, 4, "GeneralGorlok_OnDied")