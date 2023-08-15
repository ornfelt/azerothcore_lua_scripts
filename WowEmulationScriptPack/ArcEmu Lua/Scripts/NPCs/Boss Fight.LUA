duplication = 0
doubleAttck = 0
despawn = 0
------------------------
--|Halestorm Original|--
--|   Outdoor Raid   |--
--|  Twin Sorcerers  |--
------------------------
function Adomorn_Visual(pUnit, event)
    pUnit:CastSpell(31801)
    pUnit:RemoveAura(31801)
end

function Adolamin_Visual(pUnit, event)
    pUnit:CastSpell(38008)
    pUnit:RemoveAura(38008)
end

function AdolaminSecurityEnsure(pUnit, event)
    Adolamin:Despawn(1500, 0)
end

function DelayTalk(pUnit,Event)
    Adolamin:PlaySoundToSet(8920)
    Adolamin:SendChatMessage(15, 0, "Betrayed... by... my... order.")
end
----Abilities-----|
  sVolley =  38533
  sBolt   =  30055
  sNova   =  45329
------------------|


function AdomornVolley1(pUnit, event)
    local timer1 = math.random(10000, 15000)
        local volley = pUnit:GetMainTank()
        if (volley ~= nil) then
        pUnit:FullCastSpellOnTarget(sVolley, volley)
        else
        end
    pUnit:RegisterEvent("AdomornVolley2", timer1, 1)
end
function AdomornVolley2(pUnit, event)
    local timer2 = math.random(10000, 15000)
        local volley2 = pUnit:GetMainTank()
        if (volley2 ~= nil) then
        pUnit:FullCastSpellOnTarget(sVolley, volley2)
        else
        end
    pUnit:RegisterEvent("AdomornVolley1", timer2, 1)
end
---
---
---
function AdomornBolt1(pUnit, event)
    local timer1 = math.random(4000, 8000)
        local bolt = pUnit:GetRandomPlayer(0)
        if (bolt ~= nil) then
        pUnit:FullCastSpellOnTarget(sBolt, bolt)
        else
        end
    pUnit:RegisterEvent("AdomornBolt2", timer1, 1)
end
function AdomornBolt2(pUnit, event)
    local timer2 = math.random(4000, 8000)
        local bolt2 = pUnit:GetRandomPlayer(0)
        if (bolt2 ~= nil) then
        pUnit:FullCastSpellOnTarget(sBolt, bolt2)
        else
        end
    pUnit:RegisterEvent("AdomornBolt1", timer2, 1)
end
---
---
---
function AdomornNova(pUnit, event)
    local shadNov = pUnit:GetRandomPlayer(0)
    if (shadNov ~= nil) then
    pUnit:FullCastSpellOnTarget(sNova, shadNov)
    else
    end
end
---
---
---------------------------------------------
function AdomornAggro(pUnit, event)
    Adomorn = pUnit
    print "Adomorn has been engaged..."
    local start1 = math.random(10000, 14000)
    local start2 = math.random(4000, 6000)
    pUnit:PlaySoundToSet(8831)
    pUnit:SendChatMessage(14, 0, "I see endless suffering...I see torment, I see rage..I...see everything.")
    pUnit:RegisterEvent("AdomornVolley1", start1, 1)
    pUnit:RegisterEvent("AdomornBolt1", start2, 1)
    pUnit:RegisterEvent("AdomornNova", 35000, 0)
    pUnit:RegisterEvent("AdomornPhase2", 1000, 0)
end
----------------------------------------------
doom = 43439

function AdomornDoom(pUnit, evnet)
    local doomTarg = pUnit:GetRandomPlayer(0)
    if (doomTarg ~= nil) then
    pUnit:FullCastSpellOnTarget(doom, doomTarg)
    else
    end
end
---    
---
---
function AdomornPhase2(pUnit, event)
    if pUnit:GetHealthPct() <= 90 then
        pUnit:RemoveEvents()
        local start1 = math.random(10000, 14000)
        local start2 = math.random(4000, 6000)
        print "Adomorn has entered phase 2..."
        pUnit:PlaySoundToSet(8906)
        pUnit:SendChatMessage(15, 0, "I......was...pure....once.....")
        pUnit:RegisterEvent("AdomornVolley1", start1, 1)
        pUnit:RegisterEvent("AdomornBolt1", start2, 1)
        pUnit:RegisterEvent("AdomornNova", 35000, 0)
        pUnit:RegisterEvent("AdomornDoom", 23000, 0)
        pUnit:RegisterEvent("AdomornSelfBanish", 1000, 0)
    end
end
---
---
---
function AdomornSelfBanish(pUnit, event)
    if pUnit:GetHealthPct() <= 80 then
        pUnit:RemoveEvents()
        print "Adomorn has entered self-banishment..."
        pUnit:CastSpell(30231)
        pUnit:SetCombatCapable(1)
        pUnit:SetNPCFlags(4)
        pUnit:SetCombatTargetingCapable(1)
        pUnit:RegisterEvent("Adomorn_Visual", 2000, 0)
        pUnit:RegisterEvent("SoulSpawns1", 20000, 4)    
        pUnit:RegisterEvent("SoulSpawns2", 25000, 4)
        pUnit:RegisterEvent("SpawnAdolamin", 40000, 1)    
    end
end

function SoulSpawns1(pUnit, event)
    local pick = math.random(1,3)
    if pick == 1 then
    pUnit:PlaySoundToSet(8873)
    end
    if pick == 2 then
    pUnit:PlaySoundToSet(8875)
    end
    if pick == 3 then
    end
    local target = pUnit:GetRandomPlayer(0)
    local X = target:GetX()
    local Y = target:GetY()
    local Z = target:GetZ()
    local O = target:GetO()
    pUnit:SpawnCreature(48016, X + 3, Y - 3, Z + 3, O, 1720, 35000)
    pUnit:SpawnCreature(48018, X - 3, Y + 3, Z - 3, O, 1720, 35000)
end

function SoulSpawns2(pUnit, event)
    local pick = math.random(1,3)
    if pick == 1 then
    pUnit:PlaySoundToSet(8874)
    end
    if pick == 2 then
    pUnit:PlaySoundToSet(8876)
    end
    if pick == 3 then
    end
    local target = pUnit:GetMainTank()
    local X = target:GetX()
    local Y = target:GetY()
    local Z = target:GetZ()
    local O = target:GetO()
    pUnit:SpawnCreature(48015, X + 3, Y - 3, Z + 3, O, 1720, 35000)
    pUnit:SpawnCreature(48017, X - 3, Y + 3, Z - 3, O, 1720, 35000)
end
    
--[[RegisterUnitEvent(48013, 1, "AdomornAggro")--337
--RegisterUnitEvent(48013, 2, "AdomornAggro")--337
RegisterUnitEvent(48013, 2, "AdomornLeave")
RegisterUnitEvent(48013, 3, "AdomornSlay")--337
RegisterUnitEvent(48013, 4, "AdolaminSecurityEnsure")--337]]

function SpawnAdolamin(pUnit, event)
    local X = Adomorn:GetX()
    local Y = Adomorn:GetY()
    local Z = Adomorn:GetZ()
    local O = Adomorn:GetO()
    print "Adolamin has been spawned...."
    pUnit:SpawnCreature(48014, X + 2, Y + 2, Z + 2, O, 1720, 9999999)
end

--Adolamin Section


--Abilities--
fBolt     = 29954
fShock      = 38234
fVolley   = 37262 
-------------
function AdolaminVolley1(pUnit, event)
    local timer1 = math.random(10000, 15000)
        local volley = pUnit:GetMainTank()
        if (volley ~= nil) then
        pUnit:FullCastSpellOnTarget(fVolley, volley)
        else
        end
    pUnit:RegisterEvent("AdolaminVolley2", timer1, 1)
end
function AdolaminVolley2(pUnit, event)
    local timer2 = math.random(10000, 15000)
        local volley2 = pUnit:GetMainTank()
        if (volley2 ~= nil) then
        pUnit:FullCastSpellOnTarget(sVolley, volley2)
        else
        end
    pUnit:RegisterEvent("AdolaminVolley1", timer2, 1)
end
---
---
---
function AdolaminBolt1(pUnit, event)
    local timer1 = math.random(4000, 8000)
        local bolt = pUnit:GetRandomPlayer(0)
        if (bolt ~= nil) then
        pUnit:FullCastSpellOnTarget(fBolt, bolt)
        else
        end
    pUnit:RegisterEvent("AdolaminBolt2", timer1, 1)
end
function AdolaminBolt2(pUnit, event)
    local timer2 = math.random(4000, 8000)
        local bolt2 = pUnit:GetRandomPlayer(0)
        if (bolt2 ~= nil) then
        pUnit:FullCastSpellOnTarget(fBolt, bolt2)
        else
        end
    pUnit:RegisterEvent("AdolaminBolt1", timer2, 1)
end
---
---
---
function AdolaminFrostshock(pUnit, event)
    local frostTarg = pUnit:GetRandomPlayer(0)
    if (frostTarg ~=nil) then
    pUnit:FullCastSpellOnTarget(fShock, frostTarg)
    else
    end
end
---
---
---
function AdolaminAggro(pUnit, event)
    pUnit:RemoveEvents()
    print "Adolamin has entered combat and has been declared a variable..."
    Adolamin = pUnit
    local start = math.random(4000, 7000)
    local start1 = math.random(10000, 16000)
    pUnit:PlaySoundToSet(8830)
    pUnit:SendChatMessage(14, 0, "The races of the world will perish..It is only a matter of time...")
    pUnit:RegisterEvent("AdolaminVolley1", start1, 1)
    pUnit:RegisterEvent("AdolaminBolt1", start, 1)
    pUnit:RegisterEvent("AdolaminFrostshock", 35000, 0)
    pUnit:RegisterEvent("AdolaminPhase2", 1000, 0)
    Adomorn:RegisterEvent("Adomorn_Visual", 2000, 0)
end
---
---
---
sleep = 31298

function AdolaminSleep(pUnit, event)
    pUnit:PlaySoundToSet(8829)
    local blast = pUnit:GetRandomPlayer(0)
    if (blast ~= nil) then
    pUnit:SendChatMessage(14, 0, "Close your eyes...sleep.")
    pUnit:CastSpell(sleep)
    pUnit:FullCastSpellOnTarget(41374, blast)
    else
    end
end

function AdolaminPhase2(pUnit, event)
    if pUnit:GetHealthPct() <= 90 then
        pUnit:RemoveEvents()
        local start = math.random(4000, 7000)
        local start1 = math.random(10000, 16000)
        print "Adolamin has entered phase 2..."
        pUnit:PlaySoundToSet(8907)
        pUnit:SendChatMessage(15, 0, "Fought... for...righteousness.")
        pUnit:RegisterEvent("AdolaminVolley1", start1, 1)
        pUnit:RegisterEvent("AdolaminBolt1", start, 1)
        pUnit:RegisterEvent("AdolaminFrostshock", 35000, 0)
        pUnit:RegisterEvent("AdolaminSleep", 45000, 0)
        pUnit:RegisterEvent("AdolaminSelfBanish", 1000, 0)
        Adomorn:RegisterEvent("Adomorn_Visual", 2000, 0)
    end
end
---
---
---
function AdolaminSelfBanish(pUnit, event)
    if pUnit:GetHealthPct() <= 80 then
        print "Adolamin has entered self-banishment...."
        pUnit:RemoveEvents()
        Adomorn:RemoveEvents()
        Adolamin:RegisterEvent("Adolamin_Visual", 2000, 0)
        pUnit:CastSpell(30231)
        pUnit:SetCombatCapable(1)
        pUnit:SetNPCFlags(4)
        pUnit:SetCombatTargetingCapable(1)
        pUnit:PlaySoundToSet(8832)
        Adomorn:SendChatMessage(14, 0, "Soon the world will tremble...")
        Adomorn:RemoveAura(30231)
        Adomorn:SetCombatCapable(0)
        Adomorn:SetNPCFlags(0)
        Adomorn:SetCombatTargetingCapable(0)
        Adomorn:RegisterEvent("SoulSpawns1", 20000, 4)    
        Adomorn:RegisterEvent("SoulSpawns2", 25000, 4)
        Adomorn:RegisterEvent("AdomornVolley1", 4000, 1)
        Adomorn:RegisterEvent("AdomornBolt1", 13000, 1)
        Adomorn:RegisterEvent("AdomornNova", 35000, 0)
        Adomorn:RegisterEvent("AdomornDoom", 23000, 0)
        Adomorn:RegisterEvent("AdomornPhase3", 1000, 0)
    end
end

--Adomorn Continued

function AdomornPhase3(pUnit, event)
    if Adomorn:GetHealthPct() <= 50 then
        Adomorn:RemoveEvents()
        Adolamin:RemoveEvents()
        print "The twins have both entered combat..."
        Adomorn:PlaySoundToSet(8834)
        Adomorn:SendChatMessage(14, 0, "Hungry worms will feast on your rotting flesh..")
        Adolamin:RemoveAura(30231)
        Adolamin:SetCombatCapable(0)
        Adolamin:SetNPCFlags(0)
        Adolamin:SetCombatTargetingCapable(0)
        Adomorn:RegisterEvent("AdomornVolley1", 4000, 1)
        Adomorn:RegisterEvent("AdomornBolt1", 13000, 1)
        Adomorn:RegisterEvent("AdomornNova", 35000, 0)
        Adomorn:RegisterEvent("AdomornDoom", 23000, 0)
        Adolamin:RegisterEvent("AdolaminBolt1", 6000, 1)
        Adolamin:RegisterEvent("AdolaminFrostshock", 35000, 0)
        Adolamin:RegisterEvent("AdolaminSleep", 45000, 0)
        Adolamin:RegisterEvent("SoulArmy", 1000, 0)
        Adomorn:RegisterEvent ("SoulArmy", 1000, 0)
    end
end

function SoulArmy(pUnit, event)
    if Adomorn:GetHealthPct() <= 40 or Adolamin:GetHealthPct() <= 40 and duplication == 0 then
        Adomorn:RemoveEvents()
        Adolamin:RemoveEvents()
        duplication = 1
        print "The sould army event has begun...duplication set to 1..."
        local spawnPoint = pUnit:GetRandomPlayer(0)
        local X = spawnPoint:GetX()
        local Y = spawnPoint:GetY()
        local Z = spawnPoint:GetZ()
        local O = spawnPoint:GetO()
        Adomorn:PlaySoundToSet(8925)
        Adomorn:SendChatMessage(15, 0, "Truth... is... unknown... to him.")
        Adomorn:SetCombatCapable(1)
        Adolamin:SetCombatCapable(1)
        Adolamin:CastSpell(38112)
        Adomorn:CastSpell(38112)
        Adolamin:RegisterEvent("DelayTalk", 10000, 1)
        pUnit:SpawnCreature(48015, X + 3, Y - 3, Z + 3, O, 1720, 45000)
        pUnit:SpawnCreature(48018, X + 3, Y - 3, Z + 3, O, 1720, 45000)
        pUnit:SpawnCreature(48017, X - 3, Y + 3, Z - 3, O, 1720, 45000)
        pUnit:SpawnCreature(48018, X - 3, Y + 3, Z - 3, O, 1720, 45000)
        pUnit:SpawnCreature(48016, X - 3, Y + 3, Z - 3, O, 1720, 45000)
        pUnit:RegisterEvent("SoulArmy2", 40000, 5)
        Adomorn:RegisterEvent("ReEnable", 160000, 1)
        Adolamin:RegisterEvent("ReEnable", 160000, 1)
    end
end

function SoulArmy2(pUnit, event)
    local spawnPoint = pUnit:GetRandomPlayer(0)
    local X = spawnPoint:GetX()
    local Y = spawnPoint:GetY()
    local Z = spawnPoint:GetZ()
    local O = spawnPoint:GetO()
    local pick = math.random(1 , 4)
        if pick == 1 then
            pUnit:PlaySoundToSet(8873)
        end
        if pick == 2 then
            pUnit:PlaySoundToSet(8874)
        end
        if pick == 3 then
            pUnit:PlaySoundToSet(8875)
        end
        if pick == 4 then
            pUnit:PlaySoundToSet(8876)
        end
    pUnit:SpawnCreature(48015, X + 3, Y - 3, Z + 3, O, 1720, 45000)
    pUnit:SpawnCreature(48016, X - 3, Y + 3, Z - 3, O, 1720, 45000)
    pUnit:SpawnCreature(48018, X + 3, Y - 3, Z + 3, O, 1720, 45000)
    pUnit:SpawnCreature(48017, X - 3, Y + 3, Z - 3, O, 1720, 45000)
    pUnit:SpawnCreature(48015, X + 3, Y - 3, Z + 3, O, 1720, 45000)
end

function ReEnable(pUnit, event)
    Adolamin:RemoveEvents()
    Adomorn:RemoveEvents()
    Adolamin:PlaySoundToSet(8833)
    Adomorn:SendChatMessage(14, 0, "The end is upon you..")
    Adolamin:SendChatMessage(14, 0, "The end is upon you..")
    print "Combat has been re-enabled...Soul army even has ended..."
    Adomorn:RemoveAura(38112)
    Adolamin:RemoveAura(38112)
    Adomorn:SetCombatCapable(0)
    Adolamin:SetCombatCapable(0)
    Adolamin:RegisterEvent("AdolaminVolley1", 4000, 1)
    Adomorn:RegisterEvent("AdomornBolt1", 13000, 1)
    Adomorn:RegisterEvent("AdomornNova", 35000, 0)
    Adomorn:RegisterEvent("AdomornDoom", 23000, 0)
    Adolamin:RegisterEvent("AdolaminBolt1", 6000, 1)
    Adolamin:RegisterEvent("AdolaminFrostshock", 35000, 0)
    Adolamin:RegisterEvent("AdolaminSleep", 45000, 0)
    Adolamin:RegisterEvent("AdolaminFinal", 1000, 0)
    Adomorn:RegisterEvent("AdolaminFinal", 1000, 0)
end


function AdolaminFinal(pUnit, event)
    if Adomorn:GetHealthPct() <= 20 or Adolamin:GetHealthPct() <= 20 and doubleAttck == 0 then
        doubleAttck = 1
        Adolamin:RemoveEvents()
        Adomorn:RemoveEvents()
        Adomorn:PlaySoundToSet(8928)
        Adomorn:SendChatMessage(15, 0, "Kill... them... all!")
        Adolamin:SendChatMessage(15, 0, "Kill... them... all!")
        local X  = Adomorn:GetX()
        local X2 = Adolamin:GetX()
        local Y  = Adomorn:GetY()
        local Y2 = Adolamin:GetY()
        local Z  = Adomorn:GetZ()
        local Z2 = Adolamin:GetZ()
        local O  = Adomorn:GetO()
        local O2 = Adolamin:GetO()
        pUnit:SpawnCreature(48019, X + 3, Y - 3, Z + 3, O, 1719, 25000)
        pUnit:SpawnCreature(48022, X2 - 3, Y2 + 3, Z2 - 3, O2, 1719, 25000)
        pUnit:SpawnCreature(48021, X + 3, Y - 3, Z + 3, O, 1719, 25000)
        pUnit:SpawnCreature(48019, X2 - 3, Y2 + 3, Z2 - 3, O2, 1719, 25000)
        pUnit:SpawnCreature(48020, X + 3, Y - 3, Z + 3, O, 1719, 25000)
        pUnit:SpawnCreature(48021, X2 + 3, Y2 - 3, Z2 + 3, O2, 1719, 25000)
        print "The end point has been reached..spawning the Redeedmed Souls..."
        Adolamin:RegisterEvent("AdolaminVolley1", 4000, 1)
        Adomorn:RegisterEvent("AdomornBolt1", 13000, 1)
        Adomorn:RegisterEvent("AdomornNova", 35000, 0)
        Adomorn:RegisterEvent("AdomornDoom", 23000, 0)
        Adolamin:RegisterEvent("AdolaminBolt1", 6000, 1)
        Adolamin:RegisterEvent("AdolaminFrostshock", 35000, 0)
        Adolamin:RegisterEvent("AdolaminSleep", 45000, 0)
        Adomorn:RegisterEvent("AdomornFinal_RedeemedSouls", 45000, 0)
    end
end

function AdomornFinal_RedeemedSouls(pUnit, event)
    if pUnit:GetHealthPct() >= 5 then
        local X  = Adomorn:GetX()
        local X2 = Adolamin:GetX()
        local Y  = Adomorn:GetY()
        local Y2 = Adolamin:GetY()
        local Z  = Adomorn:GetZ()
        local Z2 = Adolamin:GetZ()
        local O  = Adomorn:GetO()
        local O2 = Adolamin:GetO()
        pUnit:SpawnCreature(48019, X + 3, Y - 3, Z + 3, O, 1719, 25000)
        pUnit:SpawnCreature(48020, X2 - 3, Y2 + 3, Z2 - 3, O2, 1719, 25000)
        pUnit:SpawnCreature(48021, X + 3, Y - 3, Z + 3, O, 1719, 25000)
        pUnit:SpawnCreature(48022, X2 - 3, Y2 + 3, Z2 - 3, O2, 1719, 25000)
        pUnit:SpawnCreature(48019, X + 3, Y - 3, Z + 3, O, 1719, 25000)
        pUnit:SpawnCreature(48022, X2 + 3, Y2 - 3, Z2 + 3, O2, 1719, 25000)
    else
    end
end
    

----------------------------
--Adomorn Register Events---
----------------------------
function AdomornLeave(pUnit, event)
    despawn = 1
    if despawn == 1 then
    Adolamin:Despawn(2500, 999999999)
    print "Adomorn left combat...Adolamin has been despawned...Resetting->"
    else
    end
    pUnit:RemoveEvents()
    pUnit:RemoveAura(38112)
    pUnit:RemoveAura(30231)
end

function AdomornDie(pUnit, event)
    pUnit:RemoveEvents()
    pUnit:RemoveAura(38112)
    pUnit:RemoveAura(30231)
end

function AdomornSlay(pUnit, event)
    local slay = math.random(1, 2)
    if slay == 1 then
    pUnit:PlaySoundToSet(8827)
    pUnit:SendChatMessage(14, 0, "You..are next!")
    else
    pUnit:PlaySoundToSet(8825)
    pUnit:SendChatMessage(14, 0, "You..are mine now!")
    end
end

RegisterUnitEvent(48013, 1, "AdomornAggro")
RegisterUnitEvent(48013, 2, "AdomornLeave")
RegisterUnitEvent(48013, 3, "AdomornSlay")
RegisterUnitEvent(48013, 4, "AdomornDie")
RegisterUnitEvent(48013, 4, "Brothers_RedeemedStart")
RegisterUnitEvent(48013, 4, "AdolaminSecurityEnsure")

----------------------------
--Adolamin Register Events--
----------------------------
function AdolaminLeave(pUnit, event)
    pUnit:RemoveEvents()
    pUnit:RemoveAura(38112)
    pUnit:RemoveAura(30231)
end

function AdolaminDie(pUnit, event)
    pUnit:RemoveEvents()
    pUnit:RemoveAura(38112)
    pUnit:RemoveAura(30231)
end

function AdolaminSlay(pUnit, event)
    local slay = math.random(1, 2)
    if slay == 1 then
    pUnit:PlaySoundToSet(8827)
    pUnit:SendChatMessage(14, 0, "You..are next!")
    else
    pUnit:PlaySoundToSet(8825)
    pUnit:SendChatMessage(14, 0, "You..are mine now!")
    end
end

RegisterUnitEvent(48014, 1, "AdolaminAggro")--350
RegisterUnitEvent(48014, 2, "AdolaminLeave")--350
RegisterUnitEvent(48014, 3, "AdolaminSlay")--350
RegisterUnitEvent(48014, 4, "AdolaminDie")--350

     ----------------------------
     --  Suffering Soul Events --
     ----------------------------
function SufferingDespawn(pUnit, event)
    pUnit:Despawn(1000, 0)
end

RegisterUnitEvent(48015, 2, "SufferingDespawn")
RegisterUnitEvent(48015, 4, "SufferingDespawn")
     ----------------------------
     --  Tormented Soul Events --
     ----------------------------
function TormentedSpells(pUnit, event)
    pUnit:RegisterEvent("TormentedAggro", 18000, 0)
end

function TormentedAggro(pUnit, event)
    local pickSpell = math.random(1 , 3)
    local target = pUnit:GetRandomPlayer(0)
    if pickSpell == 1 and target ~= nil then
    pUnit:FullCastSpellOnTarget(36279, target)
    else
    end
    if pickSpell == 2 and target ~= nil then
    pUnit:FullCastSpellOnTarget(40598, target)
    else
    end
    if pickSpell == 3 and target ~= nil then
    pUnit:FullCastSpellOnTarget(29924, target)
    else
    end 
end

function TormentedDeath(pUnit, event)
    pUnit:Despawn(3000, 0)
end

RegisterUnitEvent(48016, 1, "TormentedSpells")
RegisterUnitEvent(48016, 2, "TormentedDeath")
RegisterUnitEvent(48016, 4, "TormentedDeath")

     ----------------------------
     --   Broken Soul Events   --
     ----------------------------
function BrokenSoulDespawn(pUnit, event)
    pUnit:Despawn(1000, 0)
end

RegisterUnitEvent(48017, 2, "BrokenSoulDespawn")
RegisterUnitEvent(48017, 4, "BrokenSoulDespawn")


     ----------------------------
     --     Lost Soul Events   --
     ----------------------------
function LostSoulDespawn(pUnit, event)
    pUnit:Despawn(1000, 0)
end

RegisterUnitEvent(48018, 2, "LostSoulDespawn")
RegisterUnitEvent(48018, 4, "LostSoulDespawn")
     ----------------------------
     --   Redeemed Soul Events --
     ----------------------------
function Buff_Player(pUnit, event)
    local buffChoise = math.random(1 , 5)
    local buffTarg = pUnit:GetRandomPlayer(0)
    if buffChoise == 1 and buffTarg ~= nil then
    pUnit:FullCastSpellOnTarget(35733, buffTarg)
    end
    if buffChoise == 2 and buffTarg ~= nil then
    pUnit:FullCastSpellOnTarget(36881, buffTarg)
    end
    if buffChoise == 3 and buffTarg ~= nil then
    pUnit:FullCastSpellOnTarget(41373, buffTarg)
    end
    if buffChoise == 4 and buffTarg ~= nil then
    pUnit:FullCastSpellOnTarget(41196, buffTarg)
    end
    if buffChoise == 5 and buffTarg ~= nil then
    pUnit:FullCastSpellOnTarget(45848, buffTarg)
    end
end

function RedeemedAggro(pUnit, event)
    local speak = math.random(1 , 4)
        if speak == 1 then
        pUnit:SendChatMessage(12, 0, "We are free! You will pay for this Twins!")
        end
        if speak == 2 then
        pUnit:SendChatMessage(12, 0, "Brave heroes! We will help you combat these foes!")
        end
        if speak == 3 then
        end
        if speak == 4 then
        end 
    pUnit:RegisterEvent("Buff_Player", 10000, 3)
end
    
    
RegisterUnitEvent(48019, 1, "RedeemedAggro")
RegisterUnitEvent(48020, 1, "RedeemedAggro")
RegisterUnitEvent(48021, 1, "RedeemedAggro")
RegisterUnitEvent(48022, 1, "RedeemedAggro")
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
--Brother's Redeemed

function Brothers_RedeemedStart(pUnit, event)
    local X  = Adomorn:GetX()
    local X2 = Adolamin:GetX()
    local Y  = Adomorn:GetY()
    local Y2 = Adolamin:GetY()
    local Z  = Adomorn:GetZ()
    local Z2 = Adolamin:GetZ()
    local O  = Adomorn:GetO()
    local O2 = Adolamin:GetO()
    print "The Brother's Redeemed cinematic has begun..."
    Adomorn:SpawnCreature(48023, X, Y, Z, O, 35, 99999999)
    Adomorn:SpawnCreature(48024, X, Y - 3, Z, O, 35, 999999)
    AdomornPure:RegisterEvent("AdomornSpeakTrig", 1000, 1)
end

function AdomornPureDeclared(pUnit, event)
    AdomornPure = pUnit
end

function AdolaminFreeDeclared(pUnit, event)
    AdolaminFree = pUnit
end

function AdomornSpeakTrig(pUnit, event)
    pUnit:RegisterEvent("AdomornSpeak1", 6000, 1)
end

function AdomornSpeak1(pUnit, event)
    pUnit:SendChatMessage(12, 0, "Young heroes, I thank you for freeing us. My brother and I never lost hope that we would one day be saved.")
    pUnit:RegisterEvent("AdolaminSpeak1", 8000, 1)
end

function AdolaminSpeak1(pUnit, event)
    AdolaminFree:SendChatMessage(12, 0, "We were the twin sorcerers of a long lost empire. We were it's protectors..")
    AdolaminFree:RegisterEvent("AdomornSpeak2", 6000, 1)
end

function AdomornSpeak2(pUnit, event)
    AdomornPure:SendChatMessage(12, 0, "We were both given the ability at birth to punish the most evil of people by capturing their soul and giving justice as we see fit.")
    AdomornPure:RegisterEvent("AdolaminSpeak2", 10000, 1)
end

function AdolaminSpeak2(pUnit, event)
    AdolaminFree:SendChatMessage(12, 0, "This ability was strictly used for good by us and so many craved its power and my brother and I soon became targets of foreign empires..and even of our own.")
    AdolaminFree:RegisterEvent("AdomornSpeak3", 13000, 1)
end 

function AdomornSpeak3(pUnit, event)
    AdomornPure:SendChatMessage(12, 0, "If my brother and I had combined our powers we easily could have crushed any foe, but it is not in our nature to inflict death, so we fled.")
    AdomornPure:RegisterEvent("AdolaminSpeak3", 10000, 1)
end

function AdolaminSpeak3(pUnit, event)
    AdolaminFree:SendChatMessage(12, 0, "The bond between us is strong and we look out for each other, however in our travels we were approached by somone whom we both thought to be a friend.")
    AdolaminFree:RegisterEvent("AdomornSpeak4", 12000, 1)
end

function AdomornSpeak4(pUnit, event)
    AdomornPure:SendChatMessage(12, 0, "Never were we so wrong. You see mortals, my staff, Ronculous, and my brother's blade Deltheron, hold a portion of our power.")
    AdomornPure:RegisterEvent("AdolaminSpeak4", 10000, 1)
end

function AdolaminSpeak4(pUnit, event)
    AdolaminFree:SendChatMessage(12, 0, "This slime enchanted our weapons with dark magic and when we used them.....")
    AdolaminFree:RegisterEvent("AdomornSpeak5", 10000, 1)
end

function AdomornSpeak5(pUnit, event)
    AdomornPure:SendChatMessage(12, 0, "..our own souls where infused with the dark energy and we have been in agony since...")
    AdomornPure:RegisterEvent("AdolaminSpeak5", 8000, 1)
end

function AdolaminSpeak5(pUnit, event)
    AdolaminFree:SendChatMessage(12, 0, "You heroes have saved us and now we can rest in peace...Come brother let us go to rest...I am so tired..")
    AdolaminFree:RegisterEvent("AdomornSpeak6", 10000, 1)
end

function AdomornSpeak6(pUnit, event)
    AdomornPure:SendChatMessage(12, 0, "Yes, as am I brother, thank you heroes, may you have luck on your journey and may you be well guided, we will watch over you.")
    AdomornPure:RegisterEvent("TwinsExit", 12000, 1)
end

function TwinsExit(pUnit, event)
    AdolaminFree:SendChatMessage(12, 0, "Thank you.")
    AdomornPure:SendChatMessage(12, 0, "Thank you.")
    AdolaminFree:CastSpell(32343)
    AdomornPure:CastSpell(32343)
    AdomornPure:SetModel(7804)
    AdolaminFree:SetModel(7804) 
    AdolaminFree:RegisterEvent("BlessingOfTwins", 10000, 1)
    AdolaminFree:SendChatMessage(16,0,"You can feel a soothing breeze on your skin. All is well.")
end

function BlessingOfTwins(pUnit, event)
    AdolaminFree:SendChatMessage(15, 0, "May you be well on your journey....")
    AdolaminFree:RegisterEvent("BlessingOfTwins2", 6000, 1)
end

function BlessingOfTwins2 (pUnit, event)
    AdomornPure:SendChatMessage(15, 0, "and may your spirit stay strong when times are dark....")
    AdolaminFree:Despawn(500, 0)
    AdomornPure:Despawn(500, 0)
    print "The brother's redeemed cinematic has ended...the fight is over.."
end 
    

RegisterUnitEvent(48023, 18, "AdomornPureDeclared")--419
RegisterUnitEvent(48024, 18, "AdolaminFreeDeclared")--396