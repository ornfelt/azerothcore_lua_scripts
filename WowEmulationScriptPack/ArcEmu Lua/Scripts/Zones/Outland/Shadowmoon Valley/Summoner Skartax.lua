function SummonerSkartax_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("SummonerSkartax_Incinerate", 5000, 0)
	Unit:RegisterEvent("SummonerSkartax_ShadowBolt", 9000, 0)
end

function SummonerSkartax_Incinerate(Unit,Event)
	Unit:FullCastSpellOnTarget(38401,Unit:GetClosestPlayer())
end

function SummonerSkartax_ShadowBolt(Unit,Event)
	Unit:FullCastSpellOnTarget(12471,Unit:GetClosestPlayer())
end

function SummonerSkartax_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function SummonerSkartax_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21207, 1, "SummonerSkartax_OnEnterCombat")
RegisterUnitEvent(21207, 2, "SummonerSkartax_OnLeaveCombat")
RegisterUnitEvent(21207, 4, "SummonerSkartax_OnDied")