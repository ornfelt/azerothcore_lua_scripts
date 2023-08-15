function SV_OnCombat(pUnit, event)
	pUnit:RegisterEvent("SV_HeadCrack", 6000, 0)
	pUnit:RegisterEvent("SV_FireBomb", 11200, 0)
	pUnit:RegisterEvent("SV_Batter", 7000, 0)
end

function SV_HeadCrack(pUnit, event)
	pUnit:FullCastSpellOnTarget(66407, pUnit:GetMainTank())
end

function SV_FireBomb(pUnit, event)
	pUnit:FullCastSpell(66313, pUnit:GetRandomPlayer(0))
end

function SV_Batter(pUnit, event)
	pUnit:FullCastSpellOnTarget(66408, pUnit:GetMainTank())
end

function SV_Death(pUnit, event)
	pUnit:RemoveEvents()
	pUnit:Despawn(1, 0)
end

function SV_LeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
	pUnit:Despawn(1, 0)
end

function SV_KillTarget(pUnit, event)
end

RegisterUnitEvent(34800, 1, "SV_OnCombat")
RegisterUnitEvent(34800, 2, "SV_LeaveCombat")
RegisterUnitEvent(34800, 3, "SV_KillTarget")
RegisterUnitEvent(34800, 4, "SV_Death")