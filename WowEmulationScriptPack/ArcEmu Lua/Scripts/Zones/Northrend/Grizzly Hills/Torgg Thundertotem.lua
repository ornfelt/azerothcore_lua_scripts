--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TorggThundertotem_OnCombat(Unit, Event)
Unit:RegisterEvent("TorggThundertotem_ChainLightning", 9000, 0)
Unit:RegisterEvent("TorggThundertotem_CorruptedNovaTotem", 2000, 1)
Unit:RegisterEvent("TorggThundertotem_EarthShock", 6000, 0)
Unit:RegisterEvent("TorggThundertotem_HealingWave", 13000, 0)
end

function TorggThundertotem_ChainLightning(Unit, Event) 
Unit:FullCastSpellOnTarget(16033, Unit:GetMainTank()) 
end

function TorggThundertotem_CorruptedNovaTotem(Unit, Event) 
Unit:CastSpell(31991) 
end

function TorggThundertotem_EarthShock(Unit, Event) 
Unit:FullCastSpellOnTarget(15501, Unit:GetMainTank()) 
end

function TorggThundertotem_HealingWave(Unit, Event) 
Unit:CastSpell(15982) 
end

function TorggThundertotem_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TorggThundertotem_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TorggThundertotem_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27716, 1, "TorggThundertotem_OnCombat")
RegisterUnitEvent(27716, 2, "TorggThundertotem_OnLeaveCombat")
RegisterUnitEvent(27716, 3, "TorggThundertotem_OnKilledTarget")
RegisterUnitEvent(27716, 4, "TorggThundertotem_OnDied")