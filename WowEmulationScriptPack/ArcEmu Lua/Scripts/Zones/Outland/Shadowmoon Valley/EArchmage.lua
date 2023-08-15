function EArchmage_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("EArchmage_Spell1", 14000, 0)
	Unit:RegisterEvent("EArchmage_Spell2", 21000, 0)
	Unit:RegisterEvent("EArchmage_Spell3", 10000, 0)
end

function EArchmage_Spell1(Unit,Event)
	Unit:FullCastSpellOnTarget(37986,Unit:GetClosestPlayer())
end

function EArchmage_Spell2(Unit,Event)
	Unit:FullCastSpellOnTarget(11829,Unit:GetClosestPlayer())
end

function EArchmage_Spell3(Unit,Event)
	Unit:FullCastSpellOnTarget(13878,Unit:GetClosestPlayer())
end

function EArchmage_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function EArchmage_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(19796, 1, "EArchmage_OnEnterCombat")
RegisterUnitEvent(19796, 2, "EArchmage_OnLeaveCombat")
RegisterUnitEvent(19796, 4, "EArchmage_OnDied")