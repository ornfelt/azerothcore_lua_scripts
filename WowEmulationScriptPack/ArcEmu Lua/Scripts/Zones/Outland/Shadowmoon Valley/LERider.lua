function LERider_OnEnterCombat(Unit,Event)
	Unit:CastSpell(39782)
	Unit:CastSpellOnTarget(31888,Unit:GetClosestPlayer())
end

RegisterUnitEvent(22966, 1, "LERider_OnEnterCombat")