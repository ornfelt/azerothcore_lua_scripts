function CMyrmidon_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("CMyrmidon_Spell", 120000, 0)
end

function CMyrmidon_Spell(Unit,Event)
	Unit:FullCastSpellOnTarget(38027,Unit:GetClosestPlayer())
end

function CMyrmidon_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function CMyrmidon_OnDied(Unit,Event)
	Unit:RemoveEvents()
end


RegisterUnitEvent(19765, 1, "CMyrmidon_OnEnterCombat")
RegisterUnitEvent(19765, 2, "CMyrmidon_OnLeaveCombat")
RegisterUnitEvent(19765, 4, "CMyrmidon_OnDied")