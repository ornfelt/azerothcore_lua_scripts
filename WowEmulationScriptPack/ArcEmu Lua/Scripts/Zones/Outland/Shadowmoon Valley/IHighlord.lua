function IHighlord_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("IHighlord_Curseofflames", 240000, 0)
	Unit:RegisterEvent("IHighlord_Flamestrike", 10000, 0)
	Unit:RegisterEvent("IHighlord_Spell", 0001, 0)
end

function IHighlord_Curseofflames(Unit,Event)
	Unit:FullCastSpellOnTarget(38010,Unit:GetClosestPlayer())
end

function IHighlord_Spell(Unit,Event)
 if Unit:GetHealthPct() == 92 then 
	Unit:FullCastSpellOnTarget(38010,Unit:GetClosestPlayer())
end
end

function IHighlord_Flamestrike(Unit,Event)
	Unit:FullCastSpellOnTarget(16102,Unit:GetClosestPlayer())
end

function IHighlord_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function IHighlord_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(19797, 1, "IHighlord_OnEnterCombat")
RegisterUnitEvent(19797, 2, "IHighlord_OnLeaveCombat")
RegisterUnitEvent(19797, 4, "IHighlord_OnDied")