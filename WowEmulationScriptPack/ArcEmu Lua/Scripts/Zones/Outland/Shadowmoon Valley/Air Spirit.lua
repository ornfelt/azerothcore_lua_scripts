function AirSpirit_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("AirSpirit_Spell1", 11000, 0)
	Unit:RegisterEvent("AirSpirit_Spell2", 25000, 0)
end

function AirSpirit_Spell1(Unit,Event)
	Unit:FullCastSpellOnTarget(12058,Unit:GetClosestPlayer())
end

function AirSpirit_Spell2(Unit,Event)
	Unit:FullCastSpellOnTarget(32717,Unit:GetClosestPlayer())
end

function AirSpirit_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function AirSpirit_OnDeath(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21060, 1, "AirSpirit_OnEnterCombat")
RegisterUnitEvent(21060, 2, "AirSpirit_OnLeaveCombat")
RegisterUnitEvent(21060, 4, "AirSpirit_OnDeath")