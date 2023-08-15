function OronokTornheart_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("OronokTornheart_ChainLightning", 1200, 0)
	Unit:RegisterEvent("OronokTornheart_FrostShock", 16000, 0)
	Unit:RegisterEvent("OronokTornheart_HealingWave", 5000, 0)
end

function OronokTornheart_ChainLightning(Unit,Event)
	Unit:FullCastSpellOnTarget(16006,Unit:GetClosestPlayer())
end

function OronokTornheart_FrostShock(Unit,Event)
	Unit:FullCastSpellOnTarget(12548,Unit:GetClosestPlayer())
end

function OronokTornheart_HealingWave(Unit,Event)
	Unit:FullCastSpellOnTarget(12491,Unit:GetRandomFriend())
end

function OronokTornheart_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function OronokTornheart_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21183, 1, "OronokTornheart_OnEnterCombat")
RegisterUnitEvent(21183, 2, "OronokTornheart_OnLeaveCombat")
RegisterUnitEvent(21183, 4, "OronokTornheart_OnDied")