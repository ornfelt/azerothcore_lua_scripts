function ENWhelp_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("ENWhelp_Spell", 4000, 0)
end

function ENWhelp_Spell(Unit,Event)
	Unit:FullCastSpellOnTarget(38340,Unit:GetClosestPlayer())
end

function ENWhelp_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function ENWhelp_OnDeath(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21721, 1, "ENWhelp_OnEnterCombat")
RegisterUnitEvent(21721, 1, "ENWhelp_OnLeaveCombat")
RegisterUnitEvent(21721, 1, "ENWhelp_OnDeath")