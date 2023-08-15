function TorlothTheMagnificent_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("TorlothTheMagnificent_Cleave", 10000, 0)
	Unit:RegisterEvent("TorlothTheMagnificent_Shadowfury", 9000, 0)
	Unit:RegisterEvent("TorlothTheMagnificent_SpellReflection", 12000, 0)
end

function TorlothTheMagnificent_Cleave(Unit,Event)
	Unit:FullCastSpellOnTarget(15284,Unit:GetClosestPlayer())
end

function TorlothTheMagnificent_Shadowfury(Unit,Event)
	Unit:FullCastSpellOnTarget(39082,Unit:GetClosestPlayer())
end

function TorlothTheMagnificent_SpellReflection(Unit,Event)
	Unit:CastSpell(33961)
end

function TorlothTheMagnificent_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function TorlothTheMagnificent_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(22076, 1, "TorlothTheMagnificent_OnEnterCombat")
RegisterUnitEvent(22076, 2, "TorlothTheMagnificent_OnLeaveCombat")
RegisterUnitEvent(22076, 4, "TorlothTheMagnificent_OnDied")