function ShadowswornDrakonid_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("ShadowswornDrakonid_Cleave", 11000, 0)
	Unit:RegisterEvent("ShadowswornDrakonid_MortalStrike", 15000, 0)
	Unit:RegisterEvent("ShadowswornDrakonid_SunderArmor", 30000, 0)
end

function ShadowswornDrakonid_Cleave(Unit,Event)
	Unit:FullCastSpellOnTarget(15496,Unit:GetClosestPlayer())
end

function ShadowswornDrakonid_MortalStrike(Unit,Event)
	Unit:FullCastSpellOnTarget(17547,Unit:GetClosestPlayer())
end

function ShadowswornDrakonid_SunderArmor(Unit,Event)
	Unit:FullCastSpellOnTarget(16145,Unit:GetClosestPlayer())
end

function ShadowswornDrakonid_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function ShadowswornDrakonid_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(22072, 1, "ShadowswornDrakonid_OnEnterCombat")
RegisterUnitEvent(22072, 2, "ShadowswornDrakonid_OnLeaveCombat")
RegisterUnitEvent(22072, 4, "ShadowswornDrakonid_OnDied")