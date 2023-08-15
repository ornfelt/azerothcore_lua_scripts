function FireSpirit_OnEnterCombat(Unit,Event)
	Unit:CastSpell(36006)
	Unit:RegisterEvent("FireSpirit_Enrage", 1000, 0)
	Unit:RegisterEvent("FireSpirit_FelFireball", 3000, 0)
end

function FireSpirit_Enrage(Unit,Event)
 if Unit:GetHealthPct() == 97 then
	Unit:CastSpell(8599)
end
end

function FireSpirit_FelFireball(Unit,Event)
	Unit:FullCastSpellOnTarget(36247,Unit:GetClosestPlayer())
end

function FireSpirit_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function FireSpirit_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21061, 1, "FireSpirit_OnEnterCombat")
RegisterUnitEvent(21061, 2, "FireSpirit_OnLeaveCombat")
RegisterUnitEvent(21061, 4, "FireSpirit_OnDied")