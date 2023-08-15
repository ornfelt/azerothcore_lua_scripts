local LieutenantYveronEntryID = 85000
local HighlordDarionMograineEntryID = 85001
local HighlordVanReefEntryID = 85002
local InfusedCrystalEntryID = 85003
local VengefulGhoulEntryID = 85004
local VengefulPriestEntryID = 85005
local DefinedVariables = "scripts/DefinedVariables.lua"
dofile(DefinedVariables)
 
function LYO(pUnit, event)
        LieutenantYveron = pUnit
end
 
function HDM(pUnit, event)
        HighlordDarionMograine = pUnit
end
 
function HVR(pUnit, event)
        HighlordVanReef = pUnit
end
 
function IFC(pUnit, event)
        InfusedCrystal = pUnit
        InfusedCrystal:Root()
        InfusedCrystal:RegisterEvent("InfusedCrystalSpiritBolts", 2000, 0)
end
 
function VFG(pUnit, event)
        VengefulGhoul = pUnit
        VengefulGhoul:RegisterEvent("VengefulGhoulExplode", 15000, 1)
end
 
function VFP(pUnit, event)
        VengefulPriest = pUnit
        VengefulPriest:Root()
        VengefulPriest:RegisterEvent("VengefulPriestHeal", 1000, 1)
        VengefulPriest:RegisterEvent("VengefulPriestSmite", 3500, 0)
end
 
RegisterUnitEvent(LieutenantYveronEntryID, 18, "LYO")
RegisterUnitEvent(HighlordDarionMograineEntryID, 18, "HDM")
RegisterUnitEvent(HighlordVanReefEntryID, 18, "HVR")
RegisterUnitEvent(InfusedCrystalEntryID, 18, "IFC")
RegisterUnitEvent(VengefulGhoulEntryID, 18, "VFG")
RegisterUnitEvent(VengefulPriestEntryID, 18, "VFP")
 
function LieutenantYveron_OnGossip(pUnit, Event, player)
        LieutenantYveron:GossipCreateMenu(99, player, 0)
        LieutenantYveron:GossipMenuAddItem(1, "I want to fight with Highlord Van'Reef.", 1, 0)
        LieutenantYveron:GossipMenuAddItem(1, "I was looking for something else!", 2, 0)
        LieutenantYveron:GossipSendMenu(player)
end
 
function LieutenantYveron_GossipSelect(pUnit, Event, player, id, intid, code)
        if (intid == 1) then
          LieutenantYveron:SetUInt64Value(UNIT_NPC_FLAGS, 0x00)
                LieutenantYveron:SendChatMessage(12, 0, "Come with me, Champions!")
                LieutenantYveron:RegisterEvent("LieutenantYveronCinematic1", 5000, 1)
                player:GossipComplete(player)
        end
        if (intid == 2) then
                player:GossipComplete(player)
        end
end
 
RegisterUnitGossipEvent(LieutenantYveronEntryID, 1, "LieutenantYveron_OnGossip")
RegisterUnitGossipEvent(LieutenantYveronEntryID, 2, "LieutenantYveron_GossipSelect")
 
function LieutenantYveronCinematic1(pUnit, event)
        LieutenantYveron:SendChatMessage(12, 0, "For years nobody tried to disturb Highlord Van'reef! Now, I will try to summon him!")
            local x, y, z, o = LieutenantYveron:GetX(), LieutenantYveron:GetY(), LieutenantYveron:GetZ(), LieutenantYveron:GetO()
        LieutenantYveron:MoveTo(243.578842, -100.013771, 23.774134, 6.269094)
        LieutenantYveron:RegisterEvent("LieutenantYveronCinematic2", 8000, 1)
end
 
function LieutenantYveronCinematic2(pUnit, event)
        LieutenantYveron:SendChatMessage(14, 0, "Come here, Highlor Van'Reef, these Champions, want to fight with you, Now!")
        LieutenantYveron:CastSpell(46242)
        LieutenantYveron:SpawnCreature(HighlordVanReefEntryID, 255.243561, -100.009651, 18.679386, 3.162059, 35, 0)
        LieutenantYveron:RegisterEvent("LieutenantYveronCinematic3", 8000, 1)
end
 
function LieutenantYveronCinematic3(pUnit, event)
        HighlordVanReef:SendChatMessage(12, 0, "Finnaly, I'm alive in the Scarlet Monastery Light! I'vd stay so much into the Dark, and now, It's time to kill those Champions!")
        LieutenantYveron:RegisterEvent("LieutenantYveronCinematic4", 5000, 1)
end
 
function LieutenantYveronCinematic4(pUnit, event)
        LieutenantYveron:SendChatMessage(12, 0, "I will leave you now, Good Luck, Champions!")
        LieutenantYveron:CastSpell(61456)
        LieutenantYveron:Despawn(1600, 0)
        HighlordVanReef:RegisterEvent("HighlordDarionComing", 6000, 1)
end
 
function HighlordDarionComing(pUnit, event)
        HighlordVanReef:SendChatMessage(14, 0, "Darion?!")
        HighlordVanReef:SpawnCreature(HighlordDarionMograineEntryID, 273.646362, -100.006569, 28.869146, 3.137720, 35, 0)
        HighlordVanReef:MoveTo(259.905121, -99.929863, 18.679371, 6.264081)
        HighlordVanReef:RegisterEvent("CinematicWithDarion1", 6000, 1)
end
 
function CinematicWithDarion1(pUnit, event)
        HighlordDarionMograine:SendChatMessage(12, 0, "Stop now, Van'Reef, those Champions, will kill you! And If they don't, I will do that!")
        HighlordVanReef:RegisterEvent("CinematicWithDarion2", 2000, 1)
end
 
function CinematicWithDarion2(pUnit, event)
        HighlordVanReef:SendChatMessage(14, 0, "I don't think so, Darion! Go away now, and let us fight, you will see!")
        HighlordVanReef:RegisterEvent("CinematicWithDarion3", 4000, 1)
end
 
function CinematicWithDarion3(pUnit, event)
        HighlordDarionMograine:SendChatMessage(14, 0, "You have no chances to kill them!")
        HighlordVanReef:RegisterEvent("CinematicWithDarion4", 3000, 1)
end
 
function CinematicWithDarion4(pUnit, event)
        HighlordVanReef:RegisterEvent("CinematicEnd1", 5000, 1)
        HighlordDarionMograine:SendChatMessage(12, 0, "I will let you fight, and you will see, their power! And of course, you will be dead!")
        HighlordDarionMograine:CastSpell(21649)
        HighlordDarionMograine:Despawn(1400, 0)
end
 
function CinematicEnd1(pUnit, event)
        HighlordVanReef:MoveTo(255.325027, -99.952003, 18.679380, 3.161774)
        HighlordVanReef:SendChatMessage(14, 0, "Is time to done with you now!")
        HighlordVanReef:RegisterEvent("CinematicEndFinnaly", 5000, 1)
end
 
function CinematicEndFinnaly(pUnit, event)
        HighlordVanReef:SendChatMessage(14, 0, "Hah, now, I will kill you all!")
        HighlordVanReef:SetFaction(14)
end
 
function HighlordVanReef_onCombat(pUnit, event)
        HighlordVanReef:RegisterEvent("HighlordVanReefPhase1", 1000, 0)
        HighlordVanReef:SendChatMessage(14, 0, "Run now, till you have time!")
end
 
function HighlordVanReef_onLeaveCombat(pUnit, event)
        HighlordVanReef:RemoveEvents()
        HighlordVanReef:Despawn(1000, 0)
end
 
function HighlordVanReef_onKillPlayer(pUnit, event)
        HighlordVanReef:SendChatMessage(14, 0, "Fools!")
end
 
function HighlordVanReef_onDeath(pUnit, event)
                local x, y, z, o = HighlordVanReef:GetX(), HighlordVanReef:GetY(), HighlordVanReef:GetZ(), HighlordVanReef:GetO()
                HighlordVanReef:SpawnCreature(HighlordDarionMograineEntryID, 243.578842, -100.013771, 23.774134, 6.269094, 35, 0)
                HighlordDarionMograine:RegisterEvent("FinalOfTheBattle", 5000, 1)
        HighlordVanReef:Despawn(50000, 0)
        HighlordVanReef:RemoveEvents()
end
 
RegisterUnitEvent(HighlordVanReefEntryID, 1, "HighlordVanReef_onCombat")
RegisterUnitEvent(HighlordVanReefEntryID, 2, "HighlordVanReef_onLeaveCombat")
RegisterUnitEvent(HighlordVanReefEntryID, 3, "HighlordVanReef_onKillPlayer")
RegisterUnitEvent(HighlordVanReefEntryID, 4, "HighlordVanReef_onDeath")
 
function HighlordVanReefPhase1(pUnit, event)
        if HighlordVanReef:GetHealthPct() <= 97 then
        HighlordVanReef:RemoveEvents()
        HighlordVanReef:SendChatMessage(42, 0, "Highlord Van'Reef - Encounter Phase 1")
        HighlordVanReef:SendChatMessage(12, 0, "Scarlet Monastery, will never fall!")
        HighlordVanReef:RegisterEvent("HighlordVanReefCorruption", 2000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefCurseOfAgony", 5000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefShadowBoltVolley", 11000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefSiphonLife", 14000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefFireball", 17000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefUnstableAffliction", 21000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefBlastWave", 25000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefImmolate", 28000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefShadowFury", 30000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefFrostNova", 34000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefLightningNova", 60000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefPhase2", 1000, 0)
        end
end
 
function HighlordVanReefPhase2(pUnit, event)
        if HighlordVanReef:GetHealthPct() <= 87 then
        HighlordVanReef:RemoveEvents()
        HighlordVanReef:SendChatMessage(42, 0, "Highlord Van'Reef - Encounter Phase 2")
        HighlordVanReef:SendChatMessage(12, 0, "That is nothing, Insects!")
        HighlordVanReef:RegisterEvent("HighlordVanReefCorruption", 2000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefCurseOfAgony", 5000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefShadowBoltVolley", 11000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefSiphonLife", 14000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefFireball", 17000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefUnstableAffliction", 21000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefBlastWave", 25000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefImmolate", 28000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefShadowFury", 30000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefFrostNova", 34000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefLightningNova", 60000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefPhase3", 1000, 0)
        end
end
 
function HighlordVanReefPhase3(pUnit, event)
        if HighlordVanReef:GetHealthPct() <= 78 then
        HighlordVanReef:RemoveEvents()
        HighlordVanReef:SendChatMessage(42, 0, "Highlord Van'Reef - Encounter Phase 3")
        HighlordVanReef:SendChatMessage(12, 0, "You all will die!")
        HighlordVanReef:RegisterEvent("HighlordVanReefCorruption", 2000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefCurseOfAgony", 5000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefShadowBoltVolley", 11000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefSiphonLife", 14000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefFireball", 17000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefUnstableAffliction", 21000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefBlastWave", 25000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefImmolate", 28000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefShadowFury", 30000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefFrostNova", 34000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefLightningNova", 60000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefPhase4", 1000, 0)
        end
end
 
function HighlordVanReefPhase4(pUnit, event)
        if HighlordVanReef:GetHealthPct() <= 68 then
        HighlordVanReef:RemoveEvents()
        HighlordVanReef:SendChatMessage(42, 0, "Highlord Van'Reef - Encounter Phase 4")
        HighlordVanReef:SendChatMessage(42, 0, "An Infused Crystal had been summoned by Highlord Van'Reef!")
        HighlordVanReef:SendChatMessage(12, 0, "Die, Mortals!")
        HighlordVanReef:RegisterEvent("HighlordVanReefCrystalSummon", 1000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefCorruption", 2000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefCurseOfAgony", 5000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefShadowBoltVolley", 11000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefSiphonLife", 14000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefFireball", 17000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefUnstableAffliction", 21000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefBlastWave", 25000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefImmolate", 28000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefShadowFury", 30000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefFrostNova", 34000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefLightningNova", 60000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefPhase5", 1000, 0)
        end
end
 
function HighlordVanReefPhase5(pUnit, event)
        if HighlordVanReef:GetHealthPct() <= 55 then
        HighlordVanReef:RemoveEvents()
        HighlordVanReef:SendChatMessage(42, 0, "Highlord Van'Reef - Encounter Phase 5")
        HighlordVanReef:RegisterEvent("HighlordVanReefCorruption", 2000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefCurseOfAgony", 5000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefShadowBoltVolley", 11000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefSiphonLife", 14000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefFireball", 17000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefUnstableAffliction", 21000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefBlastWave", 25000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefImmolate", 28000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefShadowFury", 30000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefFrostNova", 34000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefLightningNova", 60000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefPhase6", 1000, 0)
        end
end
 
function HighlordVanReefPhase6(pUnit, event)
        if HighlordVanReef:GetHealthPct() <= 43 then
        HighlordVanReef:RemoveEvents()
        HighlordVanReef:SendChatMessage(42, 0, "Highlord Van'Reef - Encounter Phase 6")
        HighlordVanReef:SendChatMessage(42, 0, "An Vengeful Ghoul had been summoned by Highlord Van'Reef!")
        HighlordVanReef:RegisterEvent("HighlordVanReefVengefulGhoulSummon", 1000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefCorruption", 2000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefCurseOfAgony", 5000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefShadowBoltVolley", 11000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefSiphonLife", 14000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefFireball", 17000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefUnstableAffliction", 21000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefBlastWave", 25000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefImmolate", 28000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefShadowFury", 30000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefFrostNova", 34000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefLightningNova", 60000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefPhase7", 1000, 0)
        end
end
 
function HighlordVanReefPhase7(pUnit, event)
        if HighlordVanReef:GetHealthPct() <= 30 then
        HighlordVanReef:RemoveEvents()
        HighlordVanReef:SendChatMessage(42, 0, "Highlord Van'Reef - Encounter Phase 7")
        HighlordVanReef:RegisterEvent("HighlordVanReefCorruption", 2000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefCurseOfAgony", 5000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefShadowBoltVolley", 11000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefSiphonLife", 14000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefFireball", 17000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefUnstableAffliction", 21000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefBlastWave", 25000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefImmolate", 28000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefShadowFury", 30000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefFrostNova", 34000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefLightningNova", 60000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefPhase8", 1000, 0)
        end
end
 
function HighlordVanReefPhase8(pUnit, event)
        if HighlordVanReef:GetHealthPct() <= 18 then
        HighlordVanReef:RemoveEvents()
        HighlordVanReef:SendChatMessage(42, 0, "Highlord Van'Reef - Encounter Phase 8")
        HighlordVanReef:SendChatMessage(42, 0, "An Vengeful Priest had been summoned by Highlord Van'Reef!")
        HighlordVanReef:RegisterEvent("HighlordVanReefVengefulPriestSummon", 1500, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefCorruption", 2000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefCurseOfAgony", 5000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefShadowBoltVolley", 11000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefSiphonLife", 14000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefFireball", 17000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefUnstableAffliction", 21000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefBlastWave", 25000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefImmolate", 28000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefShadowFury", 30000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefFrostNova", 34000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefLightningNova", 60000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefPhase9", 1000, 0)
        end
end
 
function HighlordVanReefPhase9(pUnit, event)
        if HighlordVanReef:GetHealthPct() <= 10 then
        HighlordVanReef:RemoveEvents()
        HighlordVanReef:SendChatMessage(42, 0, "Highlord Van'Reef - Encounter Phase 9")
        HighlordVanReef:SendChatMessage(42, 0, "An Infused Crystal had been summoned by Highlord Van'Reef!")
        HighlordVanReef:RegisterEvent("HighlordVanReefEnrage", 1000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefCrystalSummon", 2000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefCorruption", 2000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefCurseOfAgony", 5000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefShadowBoltVolley", 11000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefSiphonLife", 14000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefFireball", 17000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefUnstableAffliction", 21000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefBlastWave", 25000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefImmolate", 28000, 1)
        HighlordVanReef:RegisterEvent("HighlordVanReefShadowFury", 30000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefFrostNova", 34000, 0)
        HighlordVanReef:RegisterEvent("HighlordVanReefLightningNova", 60000, 0)
        end
end
        
function HighlordVanReefShadowBoltVolley(pUnit, event)
                local tank = HighlordVanReef:GetMainTank()
                                if (tank ~= nil) then
                                                HighlordVanReef:FullCastSpellOnTarget(40428, tank)
                                end
end
 
function HighlordVanReefCorruption(pUnit, event)
                local tank = HighlordVanReef:GetMainTank()
                                if (tank ~= nil) then
                                                HighlordVanReef:FullCastSpellOnTarget(68133, tank)
                                end
end
 
function HighlordVanReefCurseOfAgony(pUnit, event)
                local tank = HighlordVanReef:GetMainTank()
                                if (tank ~= nil) then
                                                HighlordVanReef:FullCastSpellOnTarget(68137, tank)
                                end
end
 
function HighlordVanReefSiphonLife(pUnit, event)
                local tank = HighlordVanReef:GetMainTank()
                                if (tank ~= nil) then
                                                HighlordVanReef:FullCastSpellOnTarget(35195, tank)
                                end
end
 
function HighlordVanReefUnstableAffliction(pUnit, event)
                local tank = HighlordVanReef:GetMainTank()
                                if (tank ~= nil) then
                                                HighlordVanReef:FullCastSpellOnTarget(34439, tank)
                                end
end
 
function HighlordVanReefImmolate(pUnit, event)
                local tank = HighlordVanReef:GetMainTank()
                                if (tank ~= nil) then
                                                HighlordVanReef:FullCastSpellOnTarget(20294, tank)
                                end
end
 
function HighlordVanReefFireball(pUnit, event)
                local tank = HighlordVanReef:GetMainTank()
                                if (tank ~= nil) then
                                                HighlordVanReef:FullCastSpellOnTarget(29925, tank)
                                end
end
 
function HighlordVanReefShadowFury(pUnit, event)
                local tank = HighlordVanReef:GetMainTank()
                                if (tank ~= nil) then
                                                HighlordVanReef:FullCastSpellOnTarget(45270, tank)
                                end
end
 
function HighlordVanReefBlastWave(pUnit, event)
                local tank = HighlordVanReef:GetMainTank()
                                if (tank ~= nil) then
                                                HighlordVanReef:FullCastSpellOnTarget(36278, tank)
                                end
end
 
function HighlordVanReefLightningNova(pUnit, event)
                local tank = HighlordVanReef:GetMainTank()
                                if (tank ~= nil) then
                                                HighlordVanReef:StopMovement(5000)
                                                HighlordVanReef:FullCastSpellOnTarget(64216, tank)
                                end
end
 
function HighlordVanReefFrostNova(pUnit, event)
                local tank = HighlordVanReef:GetMainTank()
                                if (tank ~= nil) then
                                local x, y, z, o = HighlordVanReef:GetX(), HighlordVanReef:GetY(), HighlordVanReef:GetZ(), HighlordVanReef:GetO()
                                                HighlordVanReef:FullCastSpellOnTarget(65792, tank)
                                                HighlordVanReef:MoveTo(x+6, y, z, o)
                                                HighlordVanReef:RegisterEvent("HighlordVanReefFireball", 3000, 1)
                                end
end
 
function HighlordVanReefCrystalSummon(pUnit, event)
                HighlordVanReef:CastSpell(30237)
                local x, y, z, o = HighlordVanReef:GetX(), HighlordVanReef:GetY(), HighlordVanReef:GetZ(), HighlordVanReef:GetO()
                HighlordVanReef:SpawnCreature(85003, x+5, y, z, o, 14, 20000)
end
 
function HighlordVanReefVengefulGhoulSummon(pUnit, event)
                HighlordVanReef:CastSpell(21051)
                local x, y, z, o = HighlordVanReef:GetX(), HighlordVanReef:GetY(), HighlordVanReef:GetZ(), HighlordVanReef:GetO()
                HighlordVanReef:SpawnCreature(85004, x+7, y, z, o, 14, 22000)
end
 
function HighlordVanReefVengefulPriestSummon(pUnit, event)
                HighlordVanReef:CastSpell(21051)
                local x, y, z, o = HighlordVanReef:GetX(), HighlordVanReef:GetY(), HighlordVanReef:GetZ(), HighlordVanReef:GetO()
                HighlordVanReef:SpawnCreature(85005, 243.578842, -100.013771, 23.774134, 6.269094, 14, 22000)
end
 
function InfusedCrystal_onCombat(pUnit, event)
        InfusedCrystal:StopMovement(99999)
end
 
function InfusedCrystal_onLeaveCombat(pUnit, event)
        InfusedCrystal:Despawn(1, 0)
end
 
function InfusedCrystal_onDeath(pUnit, event)
        InfusedCrystal:Despawn(10, 0)
end
 
RegisterUnitEvent(InfusedCrystalEntryID, 1, "InfusedCrystal_onCombat")
RegisterUnitEvent(InfusedCrystalEntryID, 2, "InfusedCrystal_onLeaveCombat")
RegisterUnitEvent(InfusedCrystalEntryID, 4, "InfusedCrystal_onDeath")
 
function InfusedCrystalSpiritBolts(pUnit, event)
                local rmp = InfusedCrystal:GetRandomPlayer(0)
                                if (rmp ~= nil) then
                                                InfusedCrystal:StopMovement(5000)
                                                InfusedCrystal:FullCastSpellOnTarget(43382, rmp)
                                end
end
 
function VengefulGhoul_onCombat(pUnit, event)
        VengefulGhoul:RegisterEvent("VengefulGhoulExplode", 25000, 1)
end
 
function VengefulGhoul_onLeaveCombat(pUnit, event)
        VengefulGhoul:Despawn(1, 0)
end
 
function VengefulGhoul_onDeath(pUnit, event)
        VengefulGhoul:Despawn(1, 0)
end
 
RegisterUnitEvent(VengefulGhoulEntryID, 1, "VengefulGhoul_onCombat")
RegisterUnitEvent(VengefulGhoulEntryID, 2, "VengefulGhoul_onLeaveCombat")
RegisterUnitEvent(VengefulGhoulEntryID, 4, "VengefulGhoul_onDeath")
 
function VengefulGhoulExplode(pUnit, event)
                local rmp = VengefulGhoul:GetRandomPlayer(0)
                                if (rmp ~= nil) then
                                                VengefulGhoul:StopMovement(5000)
                                                VengefulGhoul:FullCastSpellOnTarget(67729, rmp)
                                end
end
 
function VengefulPriest_onCombat(pUnit, event)
        VengefulPriest:StopMovement(1000000)
end
 
function VengefulPriest_onLeaveCombat(pUnit, event)
        VengefulPriest:Despawn(1, 0)
end
 
function VengefulPriest_onDeath(pUnit, event)
        VengefulPriest:Despawn(1, 0)
end
 
RegisterUnitEvent(VengefulPriestEntryID, 1, "VengefulPriest_onCombat")
RegisterUnitEvent(VengefulPriestEntryID, 2, "VengefulPriest_onLeaveCombat")
RegisterUnitEvent(VengefulPriestEntryID, 4, "VengefulPriest_onDeath")
 
function VengefulPriestHeal(pUnit, event)
        VengefulPriest:StopMovement(6000)
        VengefulPriest:FullCastSpellOnTarget(66537, HighlordVanReef)
end
 
function VengefulPriestSmite(pUnit, event)
                local rmp = VengefulPriest:GetRandomPlayer(0)
                                if (rmp ~= nil) then
                                                VengefulPriest:StopMovement(5000)
                                                VengefulPriest:FullCastSpellOnTarget(20696, rmp)
                                end
end
 
function HighlordVanReefEnrage(pUnit, event)
        HighlordVanReef:FullCastSpellOnTarget(48193, HighlordVanReef)
end
 
function FinalOfTheBattle(pUnit, event)
        HighlordDarionMograine:CastSpell(39390)
        HighlordDarionMograine:SendChatMessage(12, 0, "Congratulations, Champions! Finnaly someone beat the Highlord Van'Reef!")
        HighlordDarionMograine:RegisterEvent("FinalOfTheBattle2", 4000, 1)
end
 
function FinalOfTheBattle2(pUnit, event)
        HighlordDarionMograine:SendChatMessage(12, 0, "Next Challenge, will come next week, so be ready!")
        HighlordDarionMograine:RegisterEvent("FinalOfTheBattle3", 5000, 1)
end
 
function FinalOfTheBattle3(pUnit, event)
        HighlordDarionMograine:SendChatMessage(12, 0, "I will go now, See you later, Champions!")
        HighlordDarionMograine:RegisterEvent("FinalOfTheBattle4", 2000, 1)
end
 
function FinalOfTheBattle4(pUnit, event)
        HighlordDarionMograine:CastSpell(21649)
        HighlordDarionMograine:Despawn(1400, 0)
end