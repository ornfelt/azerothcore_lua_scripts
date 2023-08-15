--yiera--

function Guard_OnCombat(pUnit, event)
pUnit:RegisterEvent("Guard_Spell1", 2000, 900)
end

function Guard_Spell1(pUnit, event)
pUnit:FullCastSpellOnTarget(55703, pUnit:GetMainTank())
end

function Guard_OnLeaveCombat(pUnit, event)
pUnit:RemoveEvents()
end

function Guard_OnKilledTarget(pUnit, event)
end

function Guard_OnDied(pUnit, event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(100100, 1, "Guard_OnCombat")
RegisterUnitEvent(100100, 2, "Guard_OnLeaveCombat")
RegisterUnitEvent(100100, 3, "Guard_OnKilledTarget")
RegisterUnitEvent(100100, 4, "Guard_OnDied")