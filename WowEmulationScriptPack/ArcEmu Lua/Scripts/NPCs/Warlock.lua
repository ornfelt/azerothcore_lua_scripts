--yiera--

function Warlock_OnCombat(pUnit, event)
pUnit:RegisterEvent("Warlock_Spell1", 3000, 900)
pUnit:RegisterEvent("Warlock_Spell2", 5000, 300)
end

function Warlock_Spell1(pUnit, event)
pUnit:FullCastSpellOnTarget(46101, pUnit:GetRandomPlayer(7))
end

function Warlock_Spell2(pUnit, event)
pUnit:FullCastSpellOnTarget(40239, pUnit:GetRandomPlayer(0))
end

function Warlock_OnLeaveCombat(pUnit, event)
pUnit:RemoveEvents()
end

function Warlock_OnKilledTarget(pUnit, event)
end

function Warlock_OnDied(pUnit, event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(100102, 1, "Warlock_OnCombat")
RegisterUnitEvent(100102, 2, "Warlock_OnLeaveCombat")
RegisterUnitEvent(100102, 3, "Warlock_OnKilledTarget")
RegisterUnitEvent(100102, 4, "Warlock_OnDied")