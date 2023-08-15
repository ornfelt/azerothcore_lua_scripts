function BlackCat_OnEnterCombat(Unit,Event)
	Unit:SendChatMessage(12, 0, "Meow!")
end

function BlackCat_OnDeath(Unit,Event)
	Unit:FullCastSpellOnTarget(39477,Unit:GetClosestPlayer())
end

RegisterUnitEvent(22816, 1, "BlackCat_OnEnterCombat")
RegisterUnitEvent(22816, 4, "BlackCat_OnDeath")