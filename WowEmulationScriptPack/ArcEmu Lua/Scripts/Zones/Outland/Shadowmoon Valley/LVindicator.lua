function LVindicator_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(13005,Unit:GetClosestPlayer())
	Unit:RegisterEvent("LVindicator_Exorcism", 11000, 0)
	Unit:RegisterEvent("LVindicator_HolyLight", 16000, 0)
end

function LVindicator_Exorcism(Unit,Event)
	Unit:FullCastSpellOnTarget(33632,Unit:GetClosestPlayer())
end

function LVindicator_HolyLight(Unit,Event)
	Unit:FullCastSpellOnTarget(13952,Unit:GetRandomFriend(0))
end

function LVindicator_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function LVindicator_OnDied(Unit,Event)
	Unit:FullCastSpellOnTarget(13903,Unit:GetRandomFriend(0))
end

RegisterUnitEvent(22861, 1, "LVindicator_OnEnterCombat")
RegisterUnitEvent(22861, 2, "LVindicator_OnLeaveCombat")
RegisterUnitEvent(22861, 4, "LVindicator_OnDied")