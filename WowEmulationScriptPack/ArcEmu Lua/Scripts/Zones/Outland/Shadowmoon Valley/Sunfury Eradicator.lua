function SunfuryEradicator_OnEnterCombat(Unit,Event)
	Unit:CastSpell(38008)
	Unit:RegisterEvent("SunfuryEradicator_FlashHeal", 15000, 0)
end

function SunfuryEradicator_FlashHeal(Unit,Event)
	Unit:FullCastSpellOnTarget(17137,Unit:GetRandomFriend())
end

function SunfuryEradicator_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function SunfuryEradicator_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21742, 1, "SunfuryEradicator_OnEnterCombat")
RegisterUnitEvent(21742, 2, "SunfuryEradicator_OnLeaveCombat")
RegisterUnitEvent(21742, 4, "SunfuryEradicator_OnDied")