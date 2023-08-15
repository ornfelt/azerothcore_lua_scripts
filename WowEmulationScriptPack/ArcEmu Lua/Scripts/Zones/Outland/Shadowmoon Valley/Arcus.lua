function Arcus_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(41440,Unit:GetClosestPlayer())
	Unit:RegisterEvent("Arcus_Spell1", 10000, 0)
	Unit:RegisterEvent("Arcus_Spell2", 30000, 0)
end

function Arcus_Spell1(Unit,Event)
	Unit:FullCastSpellOnTarget(41448,Unit:GetClosestPlayer())
end

function Arcus_Spell1(Unit,Event)
	Unit:FullCastSpellOnTarget(38370,Unit:GetClosestPlayer())
end

function Arcus_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Arcus_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(23452, 1, "Arcus_OnEnterCombat")
RegisterUnitEvent(23452, 2, "Arcus_OnLeaveCombat")
RegisterUnitEvent(23452, 4, "Arcus_OnDied")