function Mordenai_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Mordenai_Shoot", 2000, 0)
	Unit:RegisterEvent("Mordenai_Start", 2000, 0)
end

function Mordenai_Shoot(Unit,Event)
	Unit:FullCastSpellOnTarget(38372,Unit:GetClosestPlayer())
end

function Mordenai_Start(Unit,Eevnt)
 if Unit:GetHealthPct() == 98 then
	Unit:RemoveEvents()
	Unit:RegisterEvent("Mordenai_AimedShot", 16000, 0)
	Unit:RegisterEvent("Mordenai_ArcaneShot", 6000, 0)
end
end

function Mordenai_AimedShot(Unit,Event)
	Unit:FullCastSpellOnTarget(38370,Unit:GetClosestPlayer())
end

function Mordenai_ArcaneShot(Unit,Event)
	Unit:FullCastSpellOnTarget(36623,Unit:GetClosestPlayer())
end

function Mordenai_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Mordenai_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(22113, 1, "Mordenai_OnEnterCombat")
RegisterUnitEvent(22113, 2, "Mordenai_OnLeaveCombat")
RegisterUnitEvent(22113, 4, "Mordenai_OnDied")