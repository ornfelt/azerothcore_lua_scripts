function Soulguard_OnCombat (pUnit, Event)
pUnit:RegisterEvent("Soulguard_Shroud", 13000, 0)
pUnit:RegisterEvent("Soulguard_Unholy", 15000, 1)
end

function Soulguard_Shroud (pUnit, Event)
pUnit:CastSpell(69056)
end

function Soulguard_Unholy (pUnit, Event)
pUnit:CastSpell(69053)
end

function Soulguard_OnKillPlr (pUnit, Event)
end

function Soulguard_OnDeath (pUnit, Event)
pUnit:RemoveEvents()
end

function Soulguard_OnLeaveCombat (pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(36478, 1, "Soulguard_OnCombat")
RegisterUnitEvent(36478, 2, "Soulguard_OnLeaveCombat")
RegisterUnitEvent(36478, 3, "Soulguard_OnKillPlr")
RegisterUnitEvent(36478, 4, "Soulguard_OnDeath")
