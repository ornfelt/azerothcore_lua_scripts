--===========Defines=============--
local Mimiron
local nMimiron = 33350
 
local MK_II     --Leviathan MK II (botton)
local nMK_II = 33432
--MK II spells
local Prox_Mine
local nProx_Mine = 34362
        local nExplosion = 66351
local nNapalm_Shell = 63666
local nPlasma_Blast = 62997
local nShock_Blast = 63631
 
 
local VX_001    -- VX-001 (middle)
local nVX_001 = 33651
-- VX-001 spells
local nRapid_Burst = 63387
local nSpinning_Up = 63414
local nLaser_Barrage = 63293
local nRocket_Strike = 63041
local nHeat_Wave = 63677
 
 
local ACU               --Aerial Command Unit(head)
local nACU = 33670
--ACU spells
local nPlasma_Ball = 63689
local Assault_Bot --red beam
local nAssault_Bot = 34057
        local nMagnetic_Field = 64668
        local Magnetic_Core --item...wtf do I do with it?
local Bomb_Bot -- deal 9,425 to 10,575 damage spawn underneath ACU
local nBomb_Bot = 33836
local Junk_Bot -- green beam
local nJunk_Bot = 33855
 
local UNIT_FLAG_DEFAULT
local phase = 0
 
 
--== Hardmode defines would go here ==--
--Unfortunately, I haven't done hardmode
--and I don't script encounters that I've
--never done.
 
--#############################--
--#############################--
--=============Phases==========--
--#############################--
--#############################--
 
function Phase_Switch(Unit, Event)
        if (phase < 1) then
                MK_II:RegisterEvent("MK_II_HP", 1000, 0)
        end
        if (phase == 1) then
                VX_001:RegisterEvent("VX_001_HP", 1000, 0)
        end
        if (phase == 2) then
                ACU:RegisterEvent("ACU_HP", 1000, 0)
        end
end
 
function MK_II_Phase(Unit, Event)
        Mimiron:PlaySoundToSet(15612)
        Mimiron:SendChatMessage(12, 0, "We haven't much time, friends! You're going to help me test out my latest and greatest creation! Now, before you change your minds, remember that you kind of owe it to me after the mess you made with the XT-002!")
        MK_II:RegisterEvent("Mines", 10000, 1)
        MK_II:RegisterEvent("Napalm_Shell", (math.random(8000, 10000)), 0)
        MK_II:RegisterEvent("Plasma_Blast", 20000, 1)
        MK_II:RegisterEvent("Shock_Blast", 30000, 1)
 
end
 
function MK_II_HP(Unit, Event)
        if (MK_II:GetHealthPct() <= 5) then
                MK_II:RegisterEvent("MK_II_to_VX_transition", 1000, 1)
                --combat incapable, remove auras, etc.,
                MK_II:SetCombatCapable(0)
                MK_II:RemoveAllAuras()
        end
end
 
function MK_II_to_VX_transition(Unit, Event)
        MK_II:RemoveEvents()
        MK_II:MoveTo(2792, 2595, 365, 3)
        Mimiron:PlaySoundToSet(15615)
        Mimiron:SendChatMessage(12, 0, "Wonderful! Positively marvelous results! Hull integrity at ninety-eight point nine percent! Barely a dent! Moving right along!")
        Mimiron:SpawnCreature(nVX_001, 2745, 2570, 365, 3, 35, 0 )
        phase = 1
        Mimiron:RegisterEvent("VX_001_Start", 7000, 1)
end
 
function VX_001_Phase(Unit, Event)
        VX_001:RegisterEvent("Rapid_Burst", 2000, 0)
        VX_001:RegisterEvent("Spinning_Up", 30000, 0)
        VX_001:RegisterEvent("Rocket_Strike", (math.random(45000, 60000)), 0)
        VX_001:RegisterEvent("Heat_Wave", 33000, 1)
end
 
function VX_001_HP(Unit, Event)
        if VX_001:GetHealthPct() <= 2 then
                VX_001:RegisterEvent("VX_to_ACU_Transition", 1000, 1)
                --combat incapable, remove auras, etc.
        end
end
 
function VX_to_ACU_Transition(Unit, Event)
        --set emote
        VX_001:RemoveEvents()
        Mimiron:PlaySoundToSet(15619)
        Mimiron:SendChatMessage(12, 0, "Thank you, friends, your efforts have yielded some fantastic data! Now, where did I put... oh, there it is!")
        --Mimiron:SpawnCreature(x, y, z, o, nACU)
        phase = 2
        Mimiron:RegisterEvent("ACU_Start", 8000, 1)
end
 
function ACU_Phase(Unit, Event)
        ACU:RegisterEvent("Plasma_Ball", 3000, 0)
        --ACU:RegisterEvent("Assault_Bot_Summon", 20000, 0)
        --ACU:RegisterEvent("Bomb_Bot_Summon", 15000, 0)
        --ACU:RegisterEvent("Junk_Bot_Summon", 14000, 0)
        if ACU:GetHealthPct() <= 2 then
                ACU:RegisterEvent("ACU_to_Voltron_Transition", 1000, 1)
                --combat incapable and the works
        end
end
 
 
--################################--
--################################--
--===========Spells===============--
--################################--
--################################--
 
--General Spells
function MimiDespawn(Unit, Event)
phase = 0
 
        Mimiron:RemoveEvents()
        Mimiron:SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_DEFAULT)
        Mimiron:Despawn(10000, 15000)
       
        MK_II:RemoveEvents()
        MK_II:SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_DEFAULT)
        MK_II:Despawn(10000, 15000)
       
        VX_001:RemoveEvents()
        VX_001:SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_DEFAULT)
        VX_001:Despawn(10000, 0)
       
        ACU:RemoveEvents()
        ACU:SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_DEFAULT)
        ACU:Despawn(10000,0)
end
 
--Starts
function MK_II_Start(Unit, Event)
        MK_II:SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_DEFAULT)
        --MK_II:SetCombatCapable(1)
end
 
function VX_001_Start(Unit, Event)
        VX_001:SetCombatCapable(1)
        VX_001:Root()
end
 
function ACU_Start(Unit, Event)
        VX_001:SetCombatCapable(1)
end
 
 
--MK II spells
function Mines(Unit, Event)     --Credits to Hypersniper for the bulk of this function http://wow-v.com/forums/index.php?topic=10930.0
        local numberofmines = math.random(8, 10)
        for i=1,numberofmines do
                --MK_II:SpawnCreature(nProx_Mine, MK_II:GetX()+450*(math.cos(i*40)*math.pi/180), MK_II:GetY()+450*(math.sin(i*40)*math.pi/180), MK_II:GetZ(), MK_II:GetO(), 35, 36000);
                MK_II:SpawnCreature(nProx_Mine, MK_II:GetX()+600*(math.cos(i*(360/(i+1)))*math.pi/180), MK_II:GetY()+600*(math.sin(i*(360/(i+1)))*math.pi/180), MK_II:GetZ(), MK_II:GetO(), 35, 36000)
        end
        MK_II:RegisterEvent("MinesRepeat", 30000, 0)
end
 
function MinesRepeat(Unit, Event)
        local numberofmines = math.random(8, 10)
        for i=1,numberofmines do
      --MK_II:SpawnCreature(nProx_Mine, MK_II:GetX()+450*(math.cos(i*40)*math.pi/180), MK_II:GetY()+450*(math.sin(i*40)*math.pi/180), MK_II:GetZ(), MK_II:GetO(), 35, 36000);
                MK_II:SpawnCreature(nProx_Mine, MK_II:GetX()+600*(math.cos(i*(360/(i+1)))*math.pi/180), MK_II:GetY()+600*(math.sin(i*(360/(i+1)))*math.pi/180), MK_II:GetZ(), MK_II:GetO(), 35, 36000)
        end
end
 
function Prox_Explode(Unit, Event)
        Prox_Mine:FullCastSpell(nExplosion)
end
 
function Napalm_Shell(Unit, Event)
        local target = MK_II:GetRandomPlayer(3) --long range
        if (target ~= nil) then
                MK_II:FullCastSpellOnTarget(nNapalm_Shell, target)
                else if (target ~= nil) then
                        local target = MK_II:GetRandomPlayer(2) --medium range
                        MK_II:FullCastSpellOnTarget(nNapalm_Shell, target)
                        else if (target ~= nil) then
                                local target = MK_II:GetRandomPlayer(1) --short range
                                MK_II:FullCastSpellOnTarget(nNapalm_Shell, target)
                                else if (target ~= nil) then --we are really in trouble
                                        local target = MK_II:GetRandomPlayer(0) --any
                                        MK_II:FullCastSpellOnTarget(nNapalm_Shell, target)
                                        else if (target ~= nil) then
                                                MK_II:FullCastSpellOnTarget(nNapalm_Shell, target)
                                        end
                                end
                        end
                end
        end
end
 
function Plasma_Blast(Unit, Event)
        local tank = MK_II:GetMainTank()
        if (tank ~= nil) then
                MK_II:FullCastSpellOnTarget(nPlasma_Blast, tank)
                MK_II:RegisterEvent("Plasma_BlastRepeat", 45000, 0)
        end
end
 
function Plasma_BlastRepeat(Unit, Event)
        local tank = MK_II:GetMainTank()
        if (tank ~= nil) then
                MK_II:FullCastSpellOnTarget(nPlasma_Blast, tank)
        end
end
 
function Shock_Blast(Unit, Event)
        MK_II:FullCastSpell(nShock_Blast)
        MK_II:RegisterEvent("Shock_BlastRepeat", (math.random(50000, 55000)), 0)
end
 
function Shock_BlastRepeat(Unit, Event)
        MK_II:FullCastSpell(nShock_Blast)
end
 
--VX-001 spells
function Rapid_Burst(Unit, Event)
        target = VX_001:GetRandomPlayer(0)
        if (target ~= nil) then
                VX_001:FullCastSpellOnTarget(nRapid_Burst, target)
        end
end
 
function Spinning_Up(Unit, Event)
        --local newO = math.random(1, 360)
        --VX_001:SetOrientation(newO)
        VX_001:FullCastSpell(nSpinning_Up)
        VX_001:RegisterEvent("Laser_Barrage", 4000, 1)
end
 
function Laser_Barrage(Unit, Event)
        --See what happens with Spinning Up
end
 
function Rocket_Strike(Unit, Event)
        local player = VX_001:GetRandomPlayer(0)
        if (player ~= nil) then
                VX_001:GetGUID(player)
                VX_001:PlaySpellVisual(player, nRocket_Strike)
                VX_001:CastSpellAoF(player:GetX(), player:GetY(), player:GetZ(), nRocket_Strike)
                --or register event to spawn rocket strike npc for pwnage
        end
end
 
function Heat_Wave(Unit, Event)
        VX_001:CastSpellAoF(VX_001:GetX(), VX_001:GetY(), VX_001:GetZ(), nHeat_Wave)
        VX_001:RegisterEvent("Heat_Wave", 33000, 0)
end
 
 
--ACU Spells
function Plasma_Ball(Unit, Event)
 
end
--[[
function Assault_Bot_Summon(Unit, Event)
        local i = math.random(1,9)
        local x = 1
        local y = 2
        local z = 365
        local o = 0
        ACU:SpawnCreature(nAssault_Bot, tCircles[i][x], tCircles[i][y], z, o, 35, 0)
end
 
function Bomb_Bot_Summon(Unit, Event)
        local x = ACU:GetX()
        local y = ACU:GetY()
        local z = ACU:GetZ()
        local o = ACU:GetO()
        ACU:SpawnCreature(nBomb_Bot, x, y, z - 15, o, 35, 0)
end
 
function Junk_Bot_Summon(Unit, Event)
        local i = math.random(1,9)
        local x = 1
        local y = 2
        local z = 365
        local o = 0
        ACU:SpawnCreature(nJunk_Bot, tCircles[i][x], tCircles[i][y], z, o, 35, 0)
end
]]--
--Summon Table--
--[[
The count starts on the one where you enter the room and
goes clockwise. Starts on the outside each time and goes in.
          x        y
1       |2704|2569|
2       |2715|2569|
3       |2727|2569|
 
4       |2765|2604|            
5       |2759|2594|
6       |2753|2584|            
 
7       |2765|2534|
8       |2759|2544|
9       |2753|2554|
]]--
tCircles = { {2704,2569}, {2715,2569}, {2727,2569}, {2765,2604}, {2759,2594}, {2753,2584}, {2765,2534}, {2759,2544}, {2753,2554} }
 
--===========Registers=============--
 
function Mimiron_OnLoad(Unit, Event)
        Mimiron = Unit
        UNIT_FLAG_DEFAULT = Unit:GetUInt64Value(UNIT_FIELD_FLAGS)
end
 
function Mimiron_OnCombat(Unit, Event)
        Mimiron:RegisterEvent("MK_II_Start", 5000, 1)
        Mimiron:RegisterEvent("Phase_Switch", 1000, 0)
        Mimiron:PlaySoundToSet(15611)
        Mimiron:SendChatMessage(12, 0, "Oh, my! I wasn't expecting company! The workshop is such a mess! How embarrassing!")
        Mimiron:SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
        Mimiron:SetCombatCapable(0)
        Mimiron:MoveTo(2745, 2566, 365, 0)
        --Mimiron:RegisterEvent("MimiRoot", 6000, 1)
end
 
--function MimiRoot(Mimiron, Event)
        --Mimiron:Root()
--end
 
function Mimiron_LeaveCombat(Unit, Event)
        Mimiron:RegisterEvent("MimiDespawn", 1000, 1)
end
 
function Mimiron_Death(Unit, Event)
        Mimiron:RemoveEvents()
        Mimiron:PlaySoundToSet(15627)
        Mimiron:SendChatMessage(12, 0, "It would appear that I made a slight miscalculation. I allowed my mind to be corrupted by that fiend in the prison! Over-riding my primary directive. All systems seem to be functional now. Clear.")
end
 
 
 
function MK_II_OnLoad(Unit, Event)
        MK_II = Unit
        MK_II:SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
        --MK_II:SetCombatCapable(0)
end
 
function MK_II_OnCombat(Unit, Event)
        MK_II:RegisterEvent("MK_II_Phase", 10000, 1)
end
 
function MK_II_LeaveCombat(Unit, Event)
        MK_II:RegisterEvent("MimiDespawn", 1000, 1)
end
 
function MK_II_Kill(Unit, Event)
        local say = math.random(1,3)
        if (say == 1) then
                Mimiron:PlaySoundToSet(15613)
                Mimiron:SendChatMessage(12, 0, "MEDIC!")
        end
        if (say == 2) then
                Mimiron:PlaySoundToSet(15614)
                Mimiron:SendChatMessage(12, 0, "I can fix that. Erm, maybe not. Sheesh, what a mess!")
        end
end
 
function MK_II_Death(Unit, Event)
        MK_II:RemoveEvents()
end
 
 
 
function VX_001_OnLoad(Unit, Event)
        VX_001 = Unit
        VX_001:SetCombatCapable(0)
end
 
function VX_001_OnCombat(Unit, Event)
        Mimiron:PlaySoundToSet(15616)
        Mimiron:SendChatMessage(12, 0, "Behold, the VX-001 anti-personnel assault cannon! You might want to take cover...")
        VX_001:RegisterEvent("VX_001_Phase", 1000, 1)
end
 
function VX_001_LeaveCombat(Unit, Event)
        VX_001:RegisterEvent("MimiDespawn", 1000, 1)
end
 
function VX_001_Kill(Unit, Event)
        local say = math.random(1,3)
        if (say ==1) then
                Mimiron:PlaySoundToSet(15617)
                Mimiron:SendChatMessage(12, 0, "Fascinating! I think they call that a clean kill!")
        end
        if (say == 2) then
                Mimiron:PlaySoundToSet(15618)
                Mimiron:SendChatMessage(12, 0, "Note to self: cannon highly effective against flesh!")
        end
end
 
function VX_001_Death(Unit, Event)
        VX_001:RemoveEvents()
end
 
 
 
function ACU_OnLoad(Unit, Event)
        ACU = Unit
        ACU:SetCombatCapable(1)
        ACU:SetFlying()
end
 
function ACU_OnCombat(Unit, Event)
        Mimiron:PlaySoundToSet(15620)
        Mimiron:SendChatMessage(12, 0, "Isn't it beautiful? I call it the magnificent aerial command unit!")
        ACU:RegisterEvent("ACU_Phase", 1000, 1)
end
 
function ACU_LeaveCombat(Unit, Event)
        ACU:RegisterEvent("MimiDespawn", 1000, 1)
end
 
function ACU_Kill(Unit, Event)
        local say = math.random(1,3)
        if (say == 1) then
                Mimiron:PlaySoundToSet(15621)
                Mimiron:SendChatMessage(12, 0, "Outplayed.")
        end
        if (say == 2) then
                Mimiron:PlaySoundToSet(15622)
                Mimiron:SendChatMessage(12, 0, "You can do better than that!")
        end
end
 
function ACU_Death(Unit, Event)
        ACU:RemoveEvents()
end
 
function Prox_Mine_OnLoad(Unit, Event)
        Prox_Mine = Unit
        Prox_Mine:Root()
        Prox_Mine:RegisterEvent("Prox_Explode", 35000, 1)
        --if someone is on top of the mine, register the event as well...
end
 
--Mimiron
RegisterUnitEvent(nMimiron, 18, "Mimiron_OnLoad")
RegisterUnitEvent(nMimiron, 1, "Mimiron_OnCombat")
RegisterUnitEvent(nMimiron, 2, "Mimiron_LeaveCombat")
RegisterUnitEvent(nMimiron, 4, "Mimiron_Death")
--MK_II
RegisterUnitEvent(nMK_II, 18, "MK_II_OnLoad")
RegisterUnitEvent(nMK_II, 1, "MK_II_OnCombat")
RegisterUnitEvent(nMK_II, 2, "MK_II_LeaveCombat")
RegisterUnitEvent(nMK_II, 3, "MK_II_Kill")
RegisterUnitEvent(nMK_II, 4, "MK_II_Death")
--VX-001
RegisterUnitEvent(nVX_001, 18, "VX_001_OnLoad")
RegisterUnitEvent(nVX_001, 1, "VX_001_OnCombat")
RegisterUnitEvent(nVX_001, 2, "VX_001_LeaveCombat")
RegisterUnitEvent(nVX_001, 3, "VX_001_Kill")
RegisterUnitEvent(nVX_001, 4, "VX_001_Death")
--ACU
RegisterUnitEvent(nACU, 18, "ACU_OnLoad")
RegisterUnitEvent(nACU, 1, "ACU_OnCombat")
RegisterUnitEvent(nACU, 2, "ACU_LeaveCombat")
RegisterUnitEvent(nACU, 3, "ACU_Kill")
RegisterUnitEvent(nACU, 4, "ACU_Death")
--Proximity Mine
RegisterUnitEvent(nProx_Mine, 18, "Prox_Mine_OnLoad")