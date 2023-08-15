----Events-----

function Ignis_OnCombat(pUnit, Event)
pUnit:SendChatMessage(14, 0, "Insolent whelps! Your blood will temper the weapons used to reclaim this world!")
end

function Ignis_OnDied(pUnit, Event)
pUnit:SendChatMessage(14, 0, "I. Have. Failed.")
end

function Ignis_OnKilledPlayer(pUnit, Event)
pUnit:SendChatMessage(14, 0, "More scraps for the scrapheap!")


pUnit:SendChatMessage(14, 0, "Your bones will serve as kindling!")
end

----Phases-----

function Phase_1(pUnit, Event)
pUnit:RemoveEvents()
pUnit:RegisterEvent("FlameJets", 2700, 0)
pUnit:RegisterEvent("Scorch", 15000, 0)
pUnit:RegisterEvent("SlagPot", 6000, 0)
pUnit:RegisterEvent("Phase_2", 1000, 0)
end

function Phase_2(pUnit, Event)
if pUnit:GetHealthPct() <= 40 then
pUnit:RegisterEvent("IronConstruct", 60000, 0)
end
end


----Spells----

function FlameJets(pUnit, Event)
pUnit:CastSpellOnTarget(62680, pUnit:GetRandomPlayer(0))
end

function Scorch(pUnit, Event)
pUnit:FullCastSpellOnTarget(62546, pUnit:GetRandomPlayer(0))
pUnit:SendChatMessage(14, 0, "Let the inferno consume you!")

pUnit:SendChatMessage(14, 0, "BURN! Burn in the makers fire!")
end

function SlagPot(pUnit, Event)
pUnit:FullCastSpellOnTarget(62717, pUnit:GetRandomPlayer(0))
pUnit:SendChatMessage(14, 0, "I will burn away your impurities!")
end

function IronConstruct(pUnit, Event)
pUnit:SendChatMessage(14, 0, "Arise, soldiers of the Iron Crucible! The Makers' will be done!")
pUnit:GetX()
pUnit:GetY()
pUnit:GetZ()
pUnit:GetO()
pUnit:SpawnCreature(33121, x, y, z, o, 14, 0)
end

RegisterUnitEvent(33118, 1, "Ignis_OnCombat")
RegisterUnitEvent(33118, 3, "Ignis_OnKilledPlayer")
RegisterUnitEvent(33118, 4, "Ignis_OnDied")
RegisterUnitEvent(33816, 1, "Defender_OnCombat")