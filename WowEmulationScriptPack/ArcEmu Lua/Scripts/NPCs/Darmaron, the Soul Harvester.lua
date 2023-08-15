local npcID = 991199

function Darmaron, the Soul Harvester_onSpawn(pUnit, Event)
pUnit:SetFaction(14)
end

function Darmaron, the Soul Harvester_OnCombat(pUnit, Event)
pUnit:SendChatMessage(14, 0, "The Legend said u would come!")
pUnit:RegisterEvent("Darmaron, the Soul Harvester_SoulFire", 6000, 0)
pUnit:RegisterEvent("Darmaron, the Soul Harvester_FlameShock,900, 2)
pUnit:RegisterEvent("Darmaron, the Soul Harvester_Phase1", 27000, 1)
end

function Darmaron, the Soul Harvester_SoulFire(pUnit, Event)
pUnit:CastSpell(47825)
end

function Darmaron, the Soul Harvester_FlameShock(pUnit, Event)
pUnit:SendChatMessage(14, 0, "BURN IN HELL!")
pUnit:FullCastSpell(49233)
end

function Darmaron, the Soul Harvester_Phase1(pUnit, Event)
pUnit:RemoveEvents()
pUnit
:SendCHatMessage(14, 0, "You stand no chance against me!"
pUnit
:FullCastSpellOnTarget(57454), pUnit:GetRandomPlayer(2))
pUnit:RegisterEvent("Darmaron, the Soul Harvester_SoulFire", 6000, 0)
pUnit:RegisterEvent(Darmaron, the Soul Harvester_Phase2", 1000, 0)
end

function Darmaron, the Soul Harvester_SoulFire(pUnit, Event)
pUnit:CastSpell(47825)
end

function Darmaron, the Soul Harvester_Phase2(pUnit, Event)
if pUnit:GetHealthpct() <= 80 then
pUnit: RemoveEvents()
pUnit:SendChatMessage(14, 0, "This is your final breath!")
pUnit:CastspellOnTarget(56939, pUnit:GetMainTank())
pUnit:RegisterEvent("Darmaron, the Soul Harvester_SoulFire", 5000, 0)
pUnit:RegisterEvent(Darmaron, the Soul Harvester_Phase3, 1000, 0)
end
end

function Darmaron, the Soul Harvester_SoulFire(pUnit, Event)
pUnit:FullCastSpell(49233)
end

function Darmaron, the Soul Harvester_Phase3(pUnit, Event)
if pUnit:GetHealthPct() <= 50 then
pUnit:RemoveEvents()
pUnit:SendChatMessage(14, 0, "More Souls to harvest!")
pUnit:FullCastSpell(47825)
pUnit:RegisterEvent("Darmaron, the Soul Harvester_FrostFire", 3000, 0)
pUnit:RegisterEvent("Darmaron, the Soul Harvester_Phase4", 1000, 0)
end
end

function Darmaron, the Soul Harvester_FrostFire(pUnit, Event)
pUnit:SendChatMessage(14, 0, "Now you're making me real angry!")
pUnit:FullCastSpellOnTarget(47610, pUnit:GetMainTank())
end

function Darmaron, the Soul Harvester_Phase4(pUnit, Event)
if pUnit:GetHealthPct() <= 25 then
pUnit:RemoveEvents()
pUnit:SendChatMessage(14, 8, "SOULS, MORE SOULS TO FEED ON!")
pUnit:CastSpell(71469)
pUnit:CastSpell(66935)
pUnit:RegisterEvent("Darmaron, the Soul Harvester_Phase5", 1000, 1
end
end

function Darmaron, the Soul Harvester_Phase5(pUnit, Event)
if pUnit:GetHealthPct() <= 1 then
pUnit:RemoveEvents()
pUnit:SendChatMessage(12, 0, "THIS IS THE END FOR U, MORTALS!")
pUnit:FullCastSpellOnTarget(37633, pUnit:GetRandomPlayer(2))
pUnit:FullCastSpell(60121)
pUnit:FullCastSpell(40657)
end
end

function Darmaron, the Soul Harvester_OnLeaveCombat(pUnit, Event)
pUnit:SendChatMessage(14, 0, "Worthless mortals!")
pUnit:RemoveEvents()
end

function Darmaron, the SOul Harvester_OnKilledTarget(pUnit, Event)
pUnit:SendChatMessage(14, 0, "Your souls, FEEDS ME!")
pUnit:CastSpell(36300)
end

function Darmaron, the Soul Harvester_OnDeath(pUnit, Event)
pUnit:RemoveEvents()
pUnit:SendChatMessage,14 ,0 "WHAT?! THE LEGEND DIDENT SAY ANYTHING ABOUT THIS!?")
pUnit:FullCastSpell(23039)
pUnit:RemoveEvents()
end

RegisterUnitEvent(npcID, 1, "Darmaron, the Soul Harvester_OnCombat")
RegisterUnitEvent(npcID, 2, "Darmaron, the Soul Harvester_OnLeaveCombat")
RegisterUnitEvent(npcID, 3, "Darmaron, the Soul Harvester_OnKilledTarget")
RegisterUnitEvent(npcID, 4, "Darmaron, the Soul Harvester_OnDeath")
RegisterUnitEvent(npcID, 18, "Darmaron, the Soul Harvester_OnSpawn")
