function Netherskate_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Netherskate_DrainMana", 1000, 0)
	Unit:RegisterEvent("Netherskate_TailSting", 32000, 0)
end

function Netherskate_DrainMana(Unit,Event)
 if Unit:GetManaPct() == 92 then
	Unit:FullCastSpellOnTarget(17008,Unit:GetRandomPlayer(4))
end
end

function Netherskate_TailSting(Unit,Event)
	Unit:FullCastSpellOnTarget(36659,Unit:GetClosestPlayer())
end

function Netherskate_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Netherskate_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21901, 1, "Netherskate_OnEnterCombat")
RegisterUnitEvent(21901, 2, "Netherskate_OnLeaveCombat")
RegisterUnitEvent(21901, 4, "Netherskate_OnDied")