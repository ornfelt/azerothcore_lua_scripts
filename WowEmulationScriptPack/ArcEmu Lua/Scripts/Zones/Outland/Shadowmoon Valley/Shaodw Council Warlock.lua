function ShadowCouncilWarlock_OnEnterCombat(Unit,Event)
	Unit:SetCombatMeleeCapable(1)
	Unit:registerEvent("ShadowCouncilWarlock_DrainLife", 24000, 0)
	Unit:registerEvent("ShadowCouncilWarlock_ShadowBolt", 2500, 0)
end

function ShadowCouncilWarlock_DrainLife(Unit,Event)
	Unit:FullCastSpellOnTarget(37992,Unit:GetClosestPlayer())
end

function ShadowCouncilWarlock_ShadowBolt(Unit,Event)
	Unit:FullCastSpellOnTarget(9613,Unit:GetClosestPlayer())
end

function ShadowCouncilWarlock_OnLeaveCombat(Unit,Event)
	Unit:SetCombatMeleeCapable(0)
	Unit:RemoveEvents()
end

function ShadowCouncilWarlock_OnDied(Unit,Event)
	Unit:SetCombatMeleeCapable(0)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21302, 1, "ShadowCouncilWarlock_OnEnterCombat")
RegisterUnitEvent(21302, 2, "ShadowCouncilWarlock_OnLeaveCombat")
RegisterUnitEvent(21302, 4, "ShadowCouncilWarlock_OnDied")