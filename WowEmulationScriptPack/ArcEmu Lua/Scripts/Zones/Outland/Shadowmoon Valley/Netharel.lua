function Netharel_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Netharel_DebilitatingStrike", 15000, 0)
	Unit:RegisterEvent("Netharel_Evasion", 30000, 0)
	Unit:RegisterEvent("Netharel_ManaBurn", 7000, 0)
	Unit:RegisterEvent("Netharel_Metamorphosis", 1000, 1)
end

function Netharel_DebilitatingStrike(Unit,Event)
	Unit:FullCastSpellOnTarget(39135,Unit:GetClosestPlayer())
end

function Netharel_Evasion(Unit,Event)
	Unit:FullCastSpellOnTarget(37683,Unit:GetClosestPlayer())
end

function Netharel_ManaBurn(Unit,Event)
	Unit:FullCastSpellOnTarget(39262,Unit:GetClosestPlayer())
end

function Netharel_Metamorphosis(Unit,Event)
 if Unit:GetHealthPct() == 10 then
	Unit:CastSpell(36298)
end
end

function Netharel_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Netharel_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21164, 1, "Netharel_OnEnterCombat")
RegisterUnitEvent(21164, 2, "Netharel_OnLeaveCombat")
RegisterUnitEvent(21164, 4, "Netharel_OnDied")