function Hobb_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(41440,Unit:GetClosestPlayer())
	Unit:RegisterEvent("Hobb_Spell1", 10000, 0)
	Unit:RegisterEvent("Hobb_Spell2", 30000, 0)
end

function Hobb_Spell1(Unit,Event)
	Unit:FullCastSpellOnTarget(41448,Unit:GetClosestPlayer())
end

function Hobb_Spell1(Unit,Event)
	Unit:FullCastSpellOnTarget(38370,Unit:GetClosestPlayer())
end

function Hobb_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Hobb_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(23434, 1, "Hobb_OnEnterCombat")
RegisterUnitEvent(23434, 2, "Hobb_OnLeaveCombat")
RegisterUnitEvent(23434, 4, "Hobb_OnDied")