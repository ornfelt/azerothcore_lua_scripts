function NethermineFlayer_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("NethermineFlayer_Rend", 30000, 0)
	Unit:RegisterEvent("NethermineFlayer_ShredArmor", 31000, 0)
end

function NethermineFlayer_Rend(Unit,Event)
	Unit:FullCastSpellOnTarget(13443,Unit:GetClosestPlayer())
end

function NethermineFlayer_ShredArmor(Unit,Event)
	Unit:FullCastSpellOnTarget(40770,Unit:GetClosestPlayer())
end

function NethermineFlayer_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function NethermineFlayer_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(23169, 1, "NethermineFlayer_OnEnterCombat")
RegisterUnitEvent(23169, 2, "NethermineFlayer_OnLeaveCombat")
RegisterUnitEvent(23169, 4, "NethermineFlayer_OnDied")