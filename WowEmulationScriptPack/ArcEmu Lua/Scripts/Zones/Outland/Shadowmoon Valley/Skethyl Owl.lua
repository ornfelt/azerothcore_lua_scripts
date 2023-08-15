function SkethylOwl_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(38254,Unit:GetClosestPlayer())
	Unit:RegisterEvent("SkethylOwl_TerrifyingScreech", 14000, 0)
end

function SkethylOwl_TerrifyingScreech(Unit,Event)
	Unit:FullCastSpellOnTarget(38021,Unit:GetClosestPlayer())
end

function SkethylOwl_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function SkethylOwl_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21450, 1, "SkethylOwl_OnEnterCombat")
RegisterUnitEvent(21450, 2, "SkethylOwl_OnLeaveCombat")
RegisterUnitEvent(21450, 4, "SkethylOwl_OnDied")