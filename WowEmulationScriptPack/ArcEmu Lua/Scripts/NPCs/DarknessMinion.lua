function DarknessMinion_Corruption(pUnit, Event)
if pUnit:GetHealthPct() < 70 then
pUnit:FullCastSpell(25419)
pUnit:RegisterEvent("DarknessMinion_Shadowbolt", 1000, 0)
end
end

function DarknessMinion_Shadowbolt(pUnit, Event)
if pUnit:GetHealthPct() < 30 then
pUnit:FullCastSpell(29640)
end
end

function DarknessMinion_start(pUnit, Event)
pUnit:RegisterEvent("DarknessMinion_Corruption", 1000, 0)
end
RegisterUnitEvent(1337134, 1, "DarknessMinion_start")