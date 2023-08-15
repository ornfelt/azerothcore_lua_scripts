function KRider_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("KRider_SnapKick", 6000, 0)
	Unit:RegisterEvent("KRider_MortalStrike", 13000, 0)
end

function KRider_SnapKick(Unit,Event)
	Unit:FullCastSpellOnTarget(15618,Unit:GetClosestPlayer())
end

function KRider_MortalStrike(Unit,Event)
	Unit:FullCastSpellOnTarget(19643,Unit:GetClosestPlayer())
end

function KRider_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function KRider_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(19364, 1, "KRider_OnEnterCombat")
RegisterUnitEvent(19364, 2, "KRider_OnLeaveCombat")
RegisterUnitEvent(19364, 4, "KRider_OnDied")