function IShadowstalker_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(7159,Unit:GetClosestPlayer())
	Unit:RegisterEvent("IShadowstalker_Backstab", 8000, 0)
end

function IShadowstalker_Backstab(Unit,Event)
	Unit:FullCastSpellOnTarget(7159,Unit:GetClosestPlayer())
end

function IShadowstalker_Stealth(Unit,Event)
	Unit:CastSpell(5916)
end

function IShadowstalker_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function IShadowstalker_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21337, 1, "IShadowstalker_OnEnterCombat")
RegisterUnitEvent(21337, 6, "IShadowstalker_Stealth")
RegisterUnitEvent(21337, 2, "IShadowstalker_OnLeaveCombat")
RegisterUnitEvent(21337, 4, "IShadowstalker_OnDied")