function Varedis_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Varedis_CurseOfFlames", 120000, 0)
	Unit:RegisterEvent("Varedis_Evasion", 24000, 0)
	Unit:RegisterEvent("Varedis_ManaBurn", 9000, 0)
end

function Varedis_CurseOfFlames(Unit,Event)
	Unit:FullCastSpellOnTarget(38010,Unit:GetClosestPlayer())
end

function Varedis_Evasion(Unit,Event)
	Unit:CastSpell(37683)
end

function Varedis_ManaBurn(Unit,Event)
	Unit:FullCastSpellOnTarget(39262,Unit:GetClosestPlayer())
end

function Varedis_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Varedis_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21178, 1, "Varedis_OnEnterCombat")
RegisterUnitEvent(21178, 2, "Varedis_OnLeaveCombat")
RegisterUnitEvent(21178, 4, "Varedis_OnDied")