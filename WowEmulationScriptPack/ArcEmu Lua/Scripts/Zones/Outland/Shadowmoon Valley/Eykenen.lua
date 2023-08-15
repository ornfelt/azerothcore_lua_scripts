function Eykenen_OnEnterCombat(Unit,Event)
	Unit:CastSpell(32734)
	Unit:RegisterEvent("Eykenen_EarthShield", 43000, 0)
	Unit:RegisterEvent("Eykenen_EarthShock", 10000, 0)
end

function Eykenen_EarthShield(Unit,Event)
	Unit:CastSpell(32734)
end

function Eykenen_EarthShock(Unit,Event)
	Unit:FullCastSpellOnTarget(13281,Unit:GetClosestPlayer())
end

function Eykenen_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Eykenen_OnDeath(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21709, 1, "Eykenen_OnEnterCombat")
RegisterUnitEvent(21709, 1, "Eykenen_OnLeaveCombat")
RegisterUnitEvent(21709, 1, "Eykenen_OnDeath")