function Alandien_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Alandien_ShadowFury", 3000, 0)
	Unit:RegisterEvent("Alandien_ManaBurn", 3000, 0)
end

function Alandien_ShadowFury(Unit,Event)
	Unit:FullCastSpellOnTarget(39082,Unit:GetClosestPlayer())
end

function Alandien_ManaBurn(Unit,Event)
	Unit:FullCastSpellOnTarget(39262,Unit:GetClosestPlayer())
end

function Alandien_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Alandien_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (21171, 1, "Alandien_OnEnterCombat")
RegisterUnitEvent (21171, 2, "Alandien_OnLeaveCombat")
RegisterUnitEvent (21171, 4, "Alandien_OnDied")