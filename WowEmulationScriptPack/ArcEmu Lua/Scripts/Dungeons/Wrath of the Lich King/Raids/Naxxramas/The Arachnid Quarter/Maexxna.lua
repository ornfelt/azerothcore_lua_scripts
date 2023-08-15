function Maexna_OnCombat(pUnit, Event)
pUnit:SendChatMessage(14, 0, "Gaaahr!")
pUnit:RegisterEvent("Maexna_WebWrap", 40000, 0)
pUnit:RegisterEvent("Maexna_WebSpray", 60000, 0)
pUnit:RegisterEvent("Maexna_PoisonShock", 15000, 0)
pUnit:RegisterEvent("Maexna_NecroticPoison", 25000, 0)
pUnit:RegisterEvent("Maexna_Phase1", 100, 0)
end

function Maexna_OnLeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function Maexna_OnKillTarget(pUnit, Event)
end

function Maexna_OnDeath(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(15952, 1, "Maexna_OnCombat")
RegisterUnitEvent(15952, 2, "Maexna_OnLeaveCombat")
RegisterUnitEvent(15952, 3, "Maexna_OnKillTarget")
RegisterUnitEvent(15952, 4, "Maexna_OnDeath")

function Maexna_WebWrap(pUnit, Event)
pUnit:FullCastSpellOnTarget(28622, pUnit:GetRandomPlayer(0))
end

function Maexna_WebSpray(pUnit, Event)
pUnit:FullCastSpellOnTarget(29484, pUnit:GetRandomPlayer(0))
end

function Maexna_PoisonShock(pUnit, Event)
pUnit:CastSpell(28741)
end

function Maexna_NecroticPoison(pUnit, Event)
pUnit:FullCastSpellOnTarget(28776, pUnit:GetRandomPlayer(0))
end

function Maexna_Frenzy(pUnit, Event)
pUnit:CastSpell(28747)
end

function Maexna_Phase1(pUnit, Event)
if pUnit:GetHealthPct() <= 30 then
pUnit:RemoveEvents()
pUnit:RegisterEvent("Maexna_Frenzy", 1000, 0)
end
end
