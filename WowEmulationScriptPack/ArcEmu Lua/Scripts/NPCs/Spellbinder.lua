--yiera--

function Spell_OnCombat(pUnit, event)
pUnit:RegisterEvent("Spell_Spell1", 3000, 900)
end

function Spell_Spell1(pUnit, event)
pUnit:FullCastSpellOnTarget(68005, pUnit:GetRandomPlayer(7))
end

function Spell_OnLeaveCombat(pUnit, event)
pUnit:RemoveEvents()
end

function Spell_OnKilledTarget(pUnit, event)
end

function Spell_OnDied(pUnit, event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(100104, 1, "Spell_OnCombat")
RegisterUnitEvent(100104, 2, "Spell_OnLeaveCombat")
RegisterUnitEvent(100104, 3, "Spell_OnKilledTarget")
RegisterUnitEvent(100104, 4, "Spell_OnDied")