--[[=========================================
 _     _    _
| |   | |  | |  /\                  /\
| |   | |  | | /  \   _ __  _ __   /  \   _ __ ___
| |   | |  | |/ /\ \ | '_ \| '_ \ / /\ \ | '__/ __|
| |___| |__| / ____ \| |_) | |_) / ____ \| | | (__
|______\____/_/    \_\ .__/| .__/_/    \_\_|  \___|
  Scripting Project  | |   | | Improved LUA Engine
                     |_|   |_|
   SVN: http://svn.burning-azzinoth.de/LUAppArc
   LOG: http://luapparc.burning-azzinoth.de/trac/timeline
   TRAC: http://luapparc.burning-azzinoth.de/trac
   ----------------------
   Original Code by DARKI
   Version 1
========================================]]--

local check = 0

function Lai_ShadowBolt(pUnit, event)        -- got no name yet
local plr = pUnit:GetRandomPlayer(0)
    if plr then
		pUnit:FullCastSpellOnTarget(29317, plr)
    else
    end
end

function Lai_Nethervapor(pUnit, event)
local plr = pUnit:GetMainTank()
    if plr then
		pUnit:SendChatMessage(12, 0, "You may not pass!")
		pUnit:FullCastSpellOnTarget(35859, plr)
    else
    end
end

function Lai_Fear(pUnit, event, miscunit)
    pUnit:SendChatMessage(12, 0, "Cower in fear!")
    pUnit:FullCastSpell(33547)          -- fear spell bugged -.-
end

function Lai_Nova(pUnit, event)
    pUnit:SendChatMessage(12, 0, "The Masters fire rages inside of me!")
    pUnit:FullCastSpell(40737)
end

function Lai_EventSummon(pUnit, Event)         -- spawns friendly npc 15m off a random player
local spawn = pUnit:GetRandomPlayer(0)
    local x = spawn:GetX()
    local y = spawn:GetY()
    local z = spawn:GetZ()
    pUnit:SpawnCreature(22990, x+15, y, z, 90, 1836, 0)
end

function Lai_EventPhase2(pUnit, event)
    pUnit:SendChatMessage(12, 0, "Im really angry now...")
    local x = pUnit:GetX()
    local y = pUnit:GetY()
    local z = pUnit:GetZ()
    pUnit:SpawnCreature(21961, x+15, y, z, 90, 14, 0)        -- spawns enemy helper npc
end

function Lai_EventPhase2Check(pUnit, event)
local health = pUnit:GetHealthPct()
    if (health < 50) then
        if (check == 0) then
            check=1
            pUnit:RegisterEvent("Lai_EventPhase2",1500, 1)
        else
        end
    else
    end
end

function Lai_OnEnterCombat(pUnit, event)    -- main mob function on entercomba
    pUnit:RegisterEvent("Lai_ShadowBolt", 18000, 0)        --
    pUnit:RegisterEvent("Lai_Nethervapor", 13000, 0)       --
    pUnit:RegisterEvent("Lai_Fear", 9000, 0)               --  test values
    pUnit:RegisterEvent("Lai_Nova", 23000, 0)              --
    pUnit:RegisterEvent("Lai_EventSummon", 1500, 1)        --
    if (check == 0) then
		pUnit:RegisterEvent("Lai_EventPhase2Check", 1500,0)
    else
    end
end

function LaiHlp_Infuse(pUnit, event)
local boss = pUnit:GetRandomFriend()
    pUnit:FullCastSpellOnTarget(40594 , boss)
end

function LaiHlp_Heal(pUnit, event)
local heal = pUnit:GetRandomFriend()
    pUnit:FullCastSpellOnTarget(23954, heal)
end

function LaiHlp_OnEnterCombat(pUnit, event)
    pUnit:SendChatMessage(12,0,"Master!! I'll assist you!")
    pUnit:RegisterEvent("LaiHlp_Infuse", 30000, 0)
    pUnit:RegisterEvent("LaiHlp_Heal", 10000, 0)
end

function Lai_OnWipe(pUnit, Event)
    pUnit:SendChatMessage(12, 0, "You lost...!")
    pUnit:RemoveEvents()
end

function Lai_Dies(pUnit, Event)
    pUnit:SendChatMessage(5, 0, "You weren't prepared! I thought...")
    pUnit:FullCastSpell(29949) -- test
    pUnit:RemoveEvents()
end

function Spawns_OnLeaveCombat(pUnit, event)         -- to despawn the event mob
    pUnit:Despawn(1000,0)
end

RegisterUnitEvent(22990, 2, "Spawns_OnLeaveCombat")
RegisterUnitEvent(23174, 2, "Spawns_OnLeaveCombat")
RegisterUnitEvent(230040, 1, "Lai_OnEnterCombat")
RegisterUnitEvent(230040, 2, "Lai_OnWipe")
RegisterUnitEvent(230040, 4, "Lai_Dies")