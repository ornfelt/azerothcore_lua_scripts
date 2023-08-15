function Barash_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Barash_RockShell", 11000, 0)
	Unit:RegisterEvent("Barash_BellowingRoar", 40000, 0)
	Unit:RegisterEvent("Barash_Rend", 5000, 0)
end

function Barash_RockShell(Unit,Event)
	Unit:FullCastSpellOnTarget(33810,Unit:GetClosestPlayer())
end

function Barash_BellowingRoar(Unit,Event)
	Unit:FullCastSpellOnTarget(40636,Unit:GetClosestPlayer())
end

function Barash_Rend(Unit,Event)
	Unit:FullCastSpellOnTarget(13443,Unit:GetClosestPlayer())
end

function Barash_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Barash_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(23269, 1, "Barash_OnEnterCombat")
RegisterUnitEvent(23269, 2, "Barash_OnLeaveCombat")
RegisterUnitEvent(23269, 4, "Barash_OnDied")