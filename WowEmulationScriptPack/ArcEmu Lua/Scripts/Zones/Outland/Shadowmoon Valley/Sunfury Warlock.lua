function SunfuryWarlock_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("SunfuryWarlock_Incinerate", 3000, 0)
	Unit:RegisterEvent("SunfuryWarlock_ShadowBolt", 9000, 0)
end

function SunfuryWarlock_Incinerate(Unit,Event)
	Unit:FullCastSpellOnTarget(32707,Unit:GetClosestPlayer())
end

function SunfuryWarlock_ShadowBolt(Unit,Event)
	Unit:FullCastSpellOnTarget(9613,Unit:GetClosestPlayer())
end

function SunfuryWarlock_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function SunfuryWarlock_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21503, 1, "SunfuryWarlock_OnEnterCombat")
RegisterUnitEvent(21503, 2, "SunfuryWarlock_OnLeaveCombat")
RegisterUnitEvent(21503, 4, "SunfuryWarlock_OnDied")