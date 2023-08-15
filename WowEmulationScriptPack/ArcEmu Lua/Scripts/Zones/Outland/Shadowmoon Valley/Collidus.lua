function Collidus_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(38932,Unit:GetClosestPlayer())
	Unit:FullCastSpellOnTarget(36414,Unit:GetClosestPlayer())
	Unit:RegisterEvent("Collidus_FocusedBursts", 40000, 0)
	Unit:RegisterEvent("Collidus_Scream", 40000, 0)
end

function Collidus_FocusedBursts(Unit,Event)
	Unit:FullCastSpellOnTarget(36414,Unit:GetClosestPlayer())
end

function Collidus_Scream(Unit,Event)
	Unit:FullCastSpellOnTarget(34322,Unit:GetClosestPlayer())
end

function Collidus_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Collidus_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(18694, 1, "Collidus_OnEnterCombat")
RegisterUnitEvent(18694, 2, "Collidus_OnLeaveCombat")
RegisterUnitEvent(18694, 4, "Collidus_OnDied")