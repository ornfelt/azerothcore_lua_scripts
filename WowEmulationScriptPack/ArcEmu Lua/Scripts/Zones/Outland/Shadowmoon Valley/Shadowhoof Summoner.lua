function ShadowhoofSummoner_OnEnterCombat(Unit,Event)
	Unit:SetCombatMeleeCapable(1)
	Unit:registerEvent("ShadowhoofSummoner_CurseOfTongues", 30000, 0)
	Unit:registerEvent("ShadowhoofSummoner_ShadowBolt", 3000, 0)
end

function ShadowhoofSummoner_CurseOfTongues(Unit,Event)
	Unit:FullCastSpellOnTarget(13338,Unit:GetClosestPlayer())
end

function ShadowhoofSummoner_ShadowBolt(Unit,Event)
	Unit:FullCastSpellOnTarget(9613,Unit:GetClosestPlayer())
end

function ShadowhoofSummoner_OnLeaveCombat(Unit,Event)
	Unit:SetCombatMeleeCapable(0)
	Unit:RemoveEvents()
end

function ShadowhoofSummoner_OnDied(Unit,Event)
	Unit:SetCombatMeleeCapable(0)
	Unit:RemoveEvents()
end

RegisterUnitEvent(22859, 1, "ShadowhoofSummoner_OnEnterCombat")
RegisterUnitEvent(22859, 2, "ShadowhoofSummoner_OnLeaveCombat")
RegisterUnitEvent(22859, 4, "ShadowhoofSummoner_OnDied")