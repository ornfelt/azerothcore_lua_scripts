function DSummoner_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("DSummoner_ShadowBolt", 10000, 0)
	Unit:RegisterEvent("DSummoner_ShadowBolt", 16000, 0)
end

function DSummoner_ShadowBolt(Unit,Event)
	Unit:FullCastSpellOnTarget(9613,Unit:GetClosestPlayer())
end

function DSummoner_FelImmolate(Unit,Event)
	Unit:FullCastSpellOnTarget(37628,Unit:GetClosestPlayer())
end

function DSummoner_OnDeath(Unit,Event)
	Unit:RemoveEvents()
end

function DSummoner_LeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(20872, 1, "DSummoner_OnEnterCombat")
RegisterUnitEvent(20872, 2, "DSummoner_LeaveCombat")
RegisterUnitEvent(20872, 4, "DSummoner_OnDeath")