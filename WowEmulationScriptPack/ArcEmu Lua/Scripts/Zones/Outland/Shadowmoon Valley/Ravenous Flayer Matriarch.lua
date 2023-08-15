function RavenousFlayerMatriarch_OnEnterCombat(Unit,Event)
	Unit:CastSpell(36464)
	Unit:RegisterEvent("RavenousFlayerMatriarch_GushingWound", 25000, 0)
end

function RavenousFlayerMatriarch_GushingWound(Unit,Event)
	Unit:FullCastSpellOnTarget(38363,Unit:GetClosestPlayer())
end

function RavenousFlayerMatriarch_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function RavenousFlayerMatriarch_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21205, 1, "RavenousFlayerMatriarch_OnEnterCombat")
RegisterUnitEvent(21205, 2, "RavenousFlayerMatriarch_OnLeaveCombat")
RegisterUnitEvent(21205, 4, "RavenousFlayerMatriarch_OnDied")