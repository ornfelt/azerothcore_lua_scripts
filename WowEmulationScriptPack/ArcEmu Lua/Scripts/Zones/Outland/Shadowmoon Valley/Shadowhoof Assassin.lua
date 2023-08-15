function ShadowhoofAssassin_OnEnterCombat(Unit,Event)
	Unit:registerEvent("ShadowhoofAssassin_DebilitatingStrike", 15000, 0)
	Unit:registerEvent("ShadowhoofAssassin_SinisterStrike", 6000, 0)
end

function ShadowhoofAssassin_DebilitatingStrike(Unit,Event)
	Unit:FullCastSpellOnTarget(37577,Unit:GetClosestPlayer())
end

function ShadowhoofAssassin_SinisterStrike(Unit,Event)
	Unit:FullCastSpellOnTarget(14873,Unit:GetClosestPlayer())
end

function ShadowhoofAssassin_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function ShadowhoofAssassin_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(22858, 1, "ShadowhoofAssassin_OnEnterCombat")
RegisterUnitEvent(22858, 2, "ShadowhoofAssassin_OnLeaveCombat")
RegisterUnitEvent(22858, 4, "ShadowhoofAssassin_OnDied")