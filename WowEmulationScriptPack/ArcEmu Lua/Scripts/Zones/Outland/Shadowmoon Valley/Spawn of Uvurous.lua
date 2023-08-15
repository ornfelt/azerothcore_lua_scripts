function SpawnOfUvuros_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(36405,Unit:GetClosestPlayer())
	Unit:RegisterEvent("SpawnOfUvuros_Bite", 4000, 0)
	Unit:RegisterEvent("SpawnOfUvuros_DoubleBreath", 15000, 0)
	Unit:RegisterEvent("SpawnOfUvuros_Growl", 1000, 1)
	Unit:RegisterEvent("SpawnOfUvuros_LavaBreath", 15000, 0)
	Unit:RegisterEvent("SpawnOfUvuros_Stomp", 9000, 0)
end

function SpawnOfUvuros_Bite(Unit,Event)
	Unit:FullCastSpellOnTarget(27050,Unit:GetClosestPlayer())
end

function SpawnOfUvuros_DoubleBreath(Unit,Event)
	Unit:FullCastSpellOnTarget(36406,Unit:GetClosestPlayer())
end

function SpawnOfUvuros_Growl(Unit,Event)
	Unit:FullCastSpellOnTarget(14921,Unit:GetClosestPlayer())
end

function SpawnOfUvuros_LavaBreath(Unit,Event)
	Unit:FullCastSpellOnTarget(58610,Unit:GetClosestPlayer())
end

function SpawnOfUvuros_Stomp(Unit,Event)
	Unit:FullCastSpellOnTarget(36405,Unit:GetClosestPlayer())
end

function SpawnOfUvuros_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function SpawnOfUvuros_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21108, 1, "SpawnOfUvuros_OnEnterCombat")
RegisterUnitEvent(21108, 2, "SpawnOfUvuros_OnLeaveCombat")
RegisterUnitEvent(21108, 4, "SpawnOfUvuros_OnDied")