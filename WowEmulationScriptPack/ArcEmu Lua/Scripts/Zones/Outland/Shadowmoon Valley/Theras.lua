function Theras_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Terrormaster_ManaBurn", 20000, 0)
	Unit:RegisterEvent("Terrormaster_Metamorphosis", 1000, 1)
	Unit:RegisterEvent("Terrormaster_Spellbreaker", 12000, 0)
end

function Theras_ManaBurn(Unit,Event)
	Unit:FullCastSpellOnTarget(39262,Unit:GetClosestPlayer())
end

function Theras_Metamorphosis(Unit,Event)
 if Unit:GetHealthPct() == 49 then
	Unit:CastSpell(36298)
end
end

function Theras_Spellbreaker(Unit,Event)
	Unit:FullCastSpellOnTarget(35871,Unit:GetClosestPlayer())
end

function Theras_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Theras_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21168, 1, "Theras_OnEnterCombat")
RegisterUnitEvent(21168, 2, "Theras_OnLeaveCombat")
RegisterUnitEvent(21168, 4, "Theras_OnDied")