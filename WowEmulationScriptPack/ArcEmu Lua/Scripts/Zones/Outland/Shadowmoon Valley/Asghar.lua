function Asghar_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Asghar_Cleave", 3300, 0)
	Unit:RegisterEvent("Asghar_DarkMending", 15000, 0)
end

function Asghar_Cleave(Unit,Event)
	Unit:FullCastSpellOnTarget(15496,Unit:GetClosestPlayer())
end

function Asghar_DarkMending(Unit,Event)
	Unit:CastSpell(16588)
end

function Asghar_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Asghar_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (22025, 1, "Asghar_OnEnterCombat")
RegisterUnitEvent (22025, 2, "Asghar_OnLeaveCombat")
RegisterUnitEvent (22025, 4, "Asghar_OnDied")