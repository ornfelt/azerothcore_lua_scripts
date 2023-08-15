--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ChillmereOracle_OnCombat(Unit, Event)
Unit:RegisterEvent("ChillmereOracle_FrostNova", 10000, 0)
Unit:RegisterEvent("ChillmereOracle_HexoftheMurloc", 8000, 2)
Unit:RegisterEvent("ChillmereOracle_IceLance", 6000, 0)
end

function ChillmereOracle_FrostNova(Unit, Event) 
Unit:CastSpell(11831) 
end

function ChillmereOracle_HexoftheMurloc(Unit, Event) 
Unit:FullCastSpellOnTarget(49935, Unit:GetMainTank()) 
end

function ChillmereOracle_IceLance(Unit, Event) 
Unit:FullCastSpellOnTarget(49906, Unit:GetMainTank()) 
end

function ChillmereOracle_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ChillmereOracle_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ChillmereOracle_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24461, 1, "ChillmereOracle_OnCombat")
RegisterUnitEvent(24461, 2, "ChillmereOracle_OnLeaveCombat")
RegisterUnitEvent(24461, 3, "ChillmereOracle_OnKilledTarget")
RegisterUnitEvent(24461, 4, "ChillmereOracle_OnDied")