function WarbringerRazuun_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("WarbringerRazuun_FelFireball", 3800, 0)
	Unit:RegisterEvent("WarbringerRazuun_MindWarp", 45000, 1)
end

function WarbringerRazuun_FelFireball(Unit,Event)
	Unit:FullCastSpellOnTarget(35913,Unit:GetClosestPlayer())
end

function WarbringerRazuun_MindWarp(Unit,Event)
	Unit:FullCastSpellOnTarget(38047,Unit:GetClosestPlayer())
end

function WarbringerRazuun_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function WarbringerRazuun_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21287, 1, "WarbringerRazuun_OnEnterCombat")
RegisterUnitEvent(21287, 2, "WarbringerRazuun_OnLeaveCombat")
RegisterUnitEvent(21287, 4, "WarbringerRazuun_OnDied")