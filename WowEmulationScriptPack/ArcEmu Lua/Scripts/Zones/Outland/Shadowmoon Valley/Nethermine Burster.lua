function NethermineBurster_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("NethermineBurster_Poison", 2000, 0)
end

function NethermineBurster_Poison(Unit,Event)
	Unit:FullCastSpellOnTarget(31747,Unit:GetClosestPlayer())
end

function NethermineBurster_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end


function NethermineBurster_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(23285, 1, "NethermineBurster_OnEnterCombat")
RegisterUnitEvent(23285, 2, "NethermineBurster_OnLeaveCombat")
RegisterUnitEvent(23285, 4, "NethermineBurster_OnDied")