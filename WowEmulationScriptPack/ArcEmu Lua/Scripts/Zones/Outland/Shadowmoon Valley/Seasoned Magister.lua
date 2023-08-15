function SeasonedMagister_OnEnterCombat(Unit,Event)
	Unit:registerEvent("SeasonedMagister_Fireball", 3000, 0)
end

function SeasonedMagister_Fireball(Unit,Event)
	Unit:FullCastSpellOnTarget(15228,Unit:GetClosestPlayer())
end

function SeasonedMagister_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function SeasonedMagister_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(22863, 1, "SeasonedMagister_OnEnterCombat")
RegisterUnitEvent(22863, 2, "SeasonedMagister_OnLeaveCombat")
RegisterUnitEvent(22863, 4, "SeasonedMagister_OnDied")