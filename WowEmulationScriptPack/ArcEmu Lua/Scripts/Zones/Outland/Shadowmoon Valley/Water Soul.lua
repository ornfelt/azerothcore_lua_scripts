function WaterSoul_OnEnterCombat(Unit,Event)
	Unit:CastSpell(35923)
end	

RegisterUnitEvent(21109, 1, "WaterSoul_OnEnterCombat")

function WaterSpirit_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("WaterSpirit_Stormbolt", 12000, 0)
end

function WaterSpirit_Stormbolt(Unit,Event)
	Unit:FullCastSpellOnTarget(38032,Unit:GetClosestPlayer())
end

function WaterSpirit_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function WaterSpirit_OnDeath(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21059, 1, "WaterSpirit_OnEnterCombat")
RegisterUnitEvent(21059, 1, "WaterSpirit_OnLeaveCombat")
RegisterUnitEvent(21059, 1, "WaterSpirit_OnDeath")