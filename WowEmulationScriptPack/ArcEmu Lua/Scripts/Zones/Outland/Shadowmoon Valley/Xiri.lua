function Xiri_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Xiri_BlindingLight", 24000, 0)
end

function Xiri_OnSpawn(Unit,Event)
	Unit:RegisterEvent("Xiri_LightOfTheNaaru1", 20000, 0)
	Unit:RegisterEvent("Xiri_LightOfTheNaaru2", 20000, 0)
	Unit:RegisterEvent("Xiri_LightOfTheNaaru3", 20000, 0)
end

function Xiri_BlindingLight(Unit,Event)
	Unit:FullCastSpellOnTarget(33805)
end

function Xiri_LightOfTheNaaru1(Unit,Event)
	Unit:CastSpell(39828)
end

function Xiri_LightOfTheNaaru2(Unit,Event)
	Unit:CastSpell(39831)
end

function Xiri_LightOfTheNaaru3(Unit,Event)
	Unit:CastSpell(39832)
end

function Xiri_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Xiri_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(18528, 1, "Xiri_OnEnterCombat")
RegisterUnitEvent(18528, 1, "Xiri_OnLeaveCombat")
RegisterUnitEvent(18528, 4, "Xiri_OnDied")
RegisterUnitEvent(18528, 6, "Xiri_OnSpawn")