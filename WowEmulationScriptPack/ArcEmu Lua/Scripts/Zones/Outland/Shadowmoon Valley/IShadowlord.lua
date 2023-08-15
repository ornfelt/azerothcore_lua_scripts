function IShadowlord_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("IShadowlord_Sleep", 000, 0)
	Unit:RegisterEvent("IShadowlord_CarrionSwarm", 000, 0)
	Unit:RegisterEvent("IShadowlord_Inferno", 000, 0)
end

function IShadowlord_Sleep(Unit,Event)
	Unit:FullCastSpellOnTarget(12098,Unit:GetClosestPlayer())
end

function IShadowlord_CarrionSwarm(Unit,Event)
	Unit:FullCastSpellOnTarget(39942,Unit:GetClosestPlayer())
end

function IShadowlord_Inferno(Unit,Event)
 if Unit:GetHealthPct() == 64 then
	Unit:FullCastSpellOnTarget(39942,Unit:GetClosestPlayer())
end
end

function IShadowlord_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function IShadowlord_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(22988, 1, "IShadowlord_OnEnterCombat")
RegisterUnitEvent(22988, 2, "IShadowlord_OnLeaveCombat")
RegisterUnitEvent(22988, 4, "IShadowlord_OnDied")