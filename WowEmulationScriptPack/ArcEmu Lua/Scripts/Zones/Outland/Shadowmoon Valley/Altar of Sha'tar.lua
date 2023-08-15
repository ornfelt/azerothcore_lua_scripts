function AltarOfShatar_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("AltarOfShatar_Net", 20000, 0)
end

function AltarofShatar_Net(Unit,Event)
	Unit:FullCastSpellOnTarget(12024,Unit:GetClosestPlayer())
end

function AltarofShatar_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function AltarofShatar_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (21986, 1, "Alandien_OnEnterCombat")
RegisterUnitEvent (21986, 2, "Alandien_OnLeaveCombat")
RegisterUnitEvent (21986, 4, "Alandien_OnDied")