function DTinkerer_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("DTinkerer_Spell", 23000, 0)
end

function DTinkerer_Spell(Unit,Event)
	Unit:FullCastSpellOnTarget(38753,Unit:GetClosestPlayer())
end

function DTinkerer_LeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function DTinkerer_OnDeath(Unit,Event)
	Unit:RemoveEvents()
	Unit:CastSpell(38107)
end

RegisterUnitEvent(19754, 1, "DTinkerer_OnEnterCombat")
RegisterUnitEvent(19754, 2, "DTinkerer_LeaveCombat")
RegisterUnitEvent(19754, 4, "DTinkerer_OnDeath")