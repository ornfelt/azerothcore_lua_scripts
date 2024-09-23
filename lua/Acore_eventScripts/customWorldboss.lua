--Copyright (C) 2022  https://github.com/55Honey
--
--This program is free software: you can redistribute it and/or modify
--it under the terms of the GNU Affero General Public License as published by
--the Free Software Foundation, either version 3 of the License, or
--(at your option) any later version.
--
--This program is distributed in the hope that it will be useful,
--but WITHOUT ANY WARRANTY; without even the implied warranty of
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--GNU Affero General Public License for more details.
--
--You should have received a copy of the GNU Affero General Public License
--along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
--
--
--
-- Created by IntelliJ IDEA.
-- User: Silvia
-- Date: 17/05/2021
-- Time: 19:50
-- To change this template use File | Settings | File Templates.
-- Originally created by Honey for Azerothcore
-- requires ElunaLua module


-- This module spawns (custom) NPCs and grants them scripted combat abilities
------------------------------------------------------------------------------------------------
-- ADMIN GUIDE:  -  compile the core with ElunaLua module
--               -  adjust config in this file
--               -  add this script to ../lua_scripts/
--               -  adjust the IDs and config flags in case of conflicts and run the associated SQL to add the required NPCs
--               -  the acore_cms module assumes that 1112001 is the boss of encounter 1 and adding +10 for each subsequent encounter
--                  (1112011 = boss for encounter 2 / 1112021 = boss for encounter 3, etc.)
------------------------------------------------------------------------------------------------
-- GM GUIDE:     -  use .startevent $event $difficulty to start and spawn
--               -  maybe offer teleports
--               -  use .stopevent to end the event and despawn the NPC
------------------------------------------------------------------------------------------------
local Config = {}                       --general config flags

local Config_npcEntry = {}              --db entry of the NPC creature to summon the boss
local Config_npcText = {}               --gossip in npc_text to be told by the summoning NPC
local Config_bossEntry = {}             --db entry of the boss creature
local Config_addEntry = {}              --db entry of the add creature

local Config_bossSpell1 = {}            --directly applied to the tank
local Config_bossSpell2 = {}            --randomly applied to a player in 35m(configurable) range
local Config_bossSpell2MaxRange = {}    --max range im m to check for targets for boss spell 2 (default 35)
local Config_bossSpell3 = {}            --on the 2nd nearest player within 30m (only when adds are dead)
local Config_bossSpell4 = {}            --on a random player within 40m (only when adds are dead)
local Config_bossSpell4Counter = {}     --amount of casts to perform for spell 4. defaults to 1
local Config_bossSpell4MaxRange = {}    --max range im m to check for targets for boss spell 4 (default 40)
local Config_bossSpell5 = {}            --directly applied to the tank with adds alive
local Config_bossSpell6 = {}            --directly applied to the tank when adds are dead
local Config_bossSpell7 = {}            --directly applied to the tank
local Config_bossSpell8 = {}            --directly applied to the tank x seconds after spell 7
local Config_bossSpell8delay = {}       --delay between spell 7 and 8. Must be smaller than timer7 / 2
local Config_bossSpellSelf = {}         --cast on boss while adds are still alive
local Config_bossSpellEnrage = {}       --cast on boss once after Config_bossSpellEnrageTimer ms have passed

local Config_bossSpellTimer1 = {}       -- This timer applies to Config_bossSpell1 (in ms)
local Config_bossSpellTimer2 = {}       -- This timer applies to Config_bossSpell2 (in ms)
local Config_bossSpellTimer3 = {}       -- This timer applies to Config_bossSpellSelf in phase 1 and Config_bossSpell3+4 randomly later (in ms)
-- local Config_bossSpellTimer4 = {}    -- Not used. Timer3 covers BossSpells 3+4
local Config_bossSpellTimer5 = {}       -- This timer applies to Config_bossSpell5+6 (in ms)
-- local Config_bossSpellTimer6 = {}    -- Not used. Timer5 covers BossSpells 5+6
local Config_bossSpellTimer7 = {}       -- This timer applies to Config_bossSpell7+8 (in ms)
-- local Config_bossSpellTimer8 = {}    -- Not used. Timer7 covers BossSpells 7+8
local Config_bossSpellEnrageTimer = {}  -- Time in ms until Config_bossSpellEnrage is cast
local Config_minPhaseForTimer7 = {}     -- From this phase on the boss will use Timer 7 to cast Spell 7+8

local Config_bossSpellModifier1bp0 = {} -- Custom base value of the spell 1s effect #1. Default if left out.
local Config_bossSpellModifier1bp1 = {} -- Custom base value of the spell 1s effect #2. Default if left out.
local Config_bossSpellModifier2bp0 = {} -- Custom base value of the spell 2s effect #1. Default if left out.
local Config_bossSpellModifier2bp1 = {} -- Custom base value of the spell 2s effect #2. Default if left out.
local Config_bossSpellModifier3bp0 = {} -- Custom base value of the spell 3s effect #1. Default if left out.
local Config_bossSpellModifier3bp1 = {} -- Custom base value of the spell 3s effect #2. Default if left out.
local Config_bossSpellModifier4bp0 = {} -- Custom base value of the spell 4s effect #1. Default if left out.
local Config_bossSpellModifier4bp1 = {} -- Custom base value of the spell 4s effect #2. Default if left out.
local Config_bossSpellModifier5bp0 = {} -- Custom base value of the spell 5s effect #1. Default if left out.
local Config_bossSpellModifier5bp1 = {} -- Custom base value of the spell 5s effect #2. Default if left out.
local Config_bossSpellModifier6bp0 = {} -- Custom base value of the spell 6s effect #1. Default if left out.
local Config_bossSpellModifier6bp1 = {} -- Custom base value of the spell 6s effect #2. Default if left out.
local Config_bossSpellModifier7bp0 = {} -- Custom base value of the spell 6s effect #1. Default if left out.
local Config_bossSpellModifier7bp1 = {} -- Custom base value of the spell 6s effect #2. Default if left out.
local Config_bossSpellModifier8bp0 = {} -- Custom base value of the spell 6s effect #1. Default if left out.
local Config_bossSpellModifier8bp1 = {} -- Custom base value of the spell 6s effect #2. Default if left out.

local Config_addHealthModifierParty = {} -- modifier to change health for party encounter. Value in the SQL applies for raid
local Config_addsAmount = {}            -- how many adds will spawn

local Config_addSpell1 = {}             -- min range 30m, 1-3rd farthest target within 30m
local Config_addSpell2 = {}             -- min range 45m, cast on tank
local Config_addSpell3 = {}             -- min range 0m, cast on Self
local Config_addSpell4 = {}             -- cast on the boss

local Config_addSpellEnrage = {}        -- This spell will be cast on the add in 5man mode only after 300 seconds
local Config_addSpellTimer1 = {}        -- This timer applies to Config_addSpell1 (in ms)
local Config_addSpellTimer2 = {}        -- This timer applies to Config_addSpell2 (in ms)
local Config_addSpellTimer3 = {}        -- This timer applies to Config_addSpell3 (in ms)
local Config_addSpellTimer4 = {}        -- This timer applies to Config_addSpell4 (in ms)

local Config_addSpellModifier1bp0 = {}     -- Custom base value of the spell 1s effect #1. Default if left out.
local Config_addSpellModifier1bp1 = {}     -- Custom base value of the spell 1s effect #2. Default if left out.
local Config_addSpellModifier2bp0 = {}     -- Custom base value of the spell 2s effect #1. Default if left out.
local Config_addSpellModifier2bp1 = {}     -- Custom base value of the spell 2s effect #2. Default if left out.
local Config_addSpellModifier3bp0 = {}     -- Custom base value of the spell 3s effect #1. Default if left out.
local Config_addSpellModifier3bp1 = {}     -- Custom base value of the spell 3s effect #2. Default if left out.

local Config_aura1Add1 = {}             -- an aura to add to the 1st add
local Config_aura2Add1 = {}             -- another aura to add to the 1st add
local Config_aura1Add2 = {}             -- an aura to add to the 2nd add
local Config_aura2Add2 = {}             -- another aura to add to the 2nd add
local Config_aura1Add3 = {}             -- an aura to add to all adds from the 3rd on
local Config_aura2Add3 = {}             -- another aura to add to all adds from the 3rd on

local Config_addSpell3Yell = {}         -- yell for the adds when Spell 3 is cast
local Config_addEnoughYell = {}         -- yell for the add at 33% and 66% hp
local Config_addEnoughSound = {}        -- sound to play when the add is at 33% and 66%
local Config_addSpell2Sound = {}        -- sound to play when add casts spell 2
local Config_bossYellPhase2 = {}        -- yell for the boss when phase 2 starts
local Config_bossSpellSelfYell = {}     -- yell for the boss when they cast on themself

local Config_fireworks = {}             -- these are the fireworks to be cast randomly for 20s when an encounter was beaten

------------------------------------------
-- Begin of config section
------------------------------------------

-- Name of Eluna dB scheme
Config.customDbName = "ac_eluna"
-- Min GM rank to start an event
Config.GMRankForEventStart = 2
-- Min GM rank to add NPCs to the db
Config.GMRankForUpdateDB = 3
-- set to 1 to print error messages to the console. Any other value including nil turns it off.
Config.printErrorsToConsole = 1
-- time in ms before adds enrage in 5man mode
Config.addEnrageTimer = 300000
-- spell to cast at 33 and 66%hp in party mode (charge with a knockback = 19471)
Config.addEnoughSpell = 19471
-- base score per encounter
Config.baseScore = 40
-- additional score per difficulty level
Config.additionalScore = 10
-- set to award score for beating raids. Any other value including nil turns it off.
Config.rewardRaid = 1
-- set to 1 to store succesful raid attempts in the db. Any other value including nil turns it off.
Config.storeRaid = 1
-- set to award score for beating party encounter. Any other value including nil turns it off.
Config.rewardParty = 0
-- set to 1 to store succesful party attempts in the db. Any other value including nil turns it off.
Config.storeParty = 1
-- npc entry for party-only mode
Config.partySelectNpc = 1112999
-- generic welcome text1
Config.defaultNpcText1 = 91101
-- generic welcome text2
Config.defaultNpcText2 = 91102
-- activate permanent 5man only NPC
Config.partySelectNpcActive = 0
-- Map where to spawn the exchange NPC
Config.InstanceId = 0
Config.MapId = 1
-- Pos where to spawn the exchange NPC
Config.NpcX = -7168.4
Config.NpcY = -3961.6
Config.NpcZ = 9.403
Config.NpcO = 6.24
Config.PartyNpcYellText = 'Come to the Gadgetzan graveyard, if you dare. Try and prove yourself to Chromie!'
Config.PartyNpcSayText = 'What are you waiting for? Bring a party of five and step up against the enemies of time!'

------------------------------------------
-- List of encounters:
-- 1: Level 50, Glorifrir Flintshoulder / Zombie Captain
-- 2: Level 40, Pondulum of Deem / Seawitch
-- 3: Level 50, Crocolisk Dundee / Aligator Minion
-- 4: Level 50, Crocolisk Bunbee / Aligator Pet
-- 5: Level 60, Crocolisk Rundee / Aligator Guard
-- 6: Level 60: One-Three-Three-Seven / Ragnarosqt
-- 7: Level 60: Big Bad Bug / Bug's Bunny
------------------------------------------

------------------------------------------
-- Begin of encounter 1 config
------------------------------------------

-- Database NPC entries. Must match the associated .sql file
Config_bossEntry[1] = 1112001           --db entry of the boss creature
Config_npcEntry[1] = 1112002            --db entry of the NPC creature to summon the boss
Config_addEntry[1] = 1112003            --db entry of the add creature
Config_npcText[1] = 91111               --gossip in npc_text to be told by the summoning NPC

-- list of spells:
Config_bossSpell1[1] = 38846            --directly applied to the tank-- Forceful Cleave (Target + nearest ally)
Config_bossSpell2[1] = 45108            --randomly applied to a player in 35m range-- CKs Fireball
Config_bossSpell2MaxRange[1] = 35       --max range im m/y to check for targets for boss spell 2 (default 35)
Config_bossSpell3[1] = 53721            --on the 2nd nearest player within 30m-- Death and decay (10% hp per second)
Config_bossSpell4[1] = 37279            --on a random player within 40m-- Rain of Fire
Config_bossSpell4Counter[1] = 1         --amount of casts to perform for spell 4. defaults to 1
Config_bossSpell4MaxRange[1] = 40       --max range im m to check for targets for boss spell 4 (default 40)
Config_bossSpell5[1] = nil              --this line is not neccesary. If a spell is missing it will just be skipped
Config_bossSpell6[1] = nil              --this line is not neccesary. If a spell is missing it will just be skipped
Config_bossSpellSelf[1] = 69898         --cast on boss while adds are still alive-- Hot
Config_bossSpellEnrage[1] = 69166       --cast on boss once after Config_bossSpellEnrageTimer ms have passed-- Soft Enrage

Config_bossSpellTimer1[1] = 19000       -- This timer applies to Config_bossSpell1
Config_bossSpellTimer2[1] = 23000       -- This timer applies to Config_bossSpell2
Config_bossSpellTimer3[1] = 11000       -- This timer applies to Config_bossSpellSelf in phase 1 and Config_bossSpell3+4 randomly later
Config_bossSpellTimer5[1] = nil         -- This timer applies to Config_bossSpell5+6
Config_bossSpellEnrageTimer[1] = 180000

Config_bossSpellModifier1bp0[1] = nil      -- base damage of the Cleave
Config_bossSpellModifier1bp1[1] = nil      -- not required if nil
Config_bossSpellModifier2bp0[1] = 2000     -- Fireball modifier hit
Config_bossSpellModifier2bp1[1] = 2000     -- Fireball modifier tick
Config_bossSpellModifier3bp0[1] = 10       -- base damage of the D&D
Config_bossSpellModifier3bp1[1] = nil      -- not required if nil
Config_bossSpellModifier4bp0[1] = 1200     -- tick damage of fire rain
Config_bossSpellModifier4bp1[1] = nil      -- not required if nil
Config_bossSpellModifier5bp0[1] = nil      -- not required if nil
Config_bossSpellModifier5bp1[1] = nil      -- not required if nil
Config_bossSpellModifier6bp0[1] = nil      -- not required if nil
Config_bossSpellModifier6bp1[1] = nil      -- not required if nil


Config_addHealthModifierParty[1] = 1    -- modifier to change health for party encounter. Value in the SQL applies for raid
Config_addsAmount[1] = 3                -- how many adds will spawn

Config_addSpell1[1] = 12421             -- min range 30m, 1-3rd farthest target within 30m -- Mithril Frag Bomb 8y 149-201 damage + stun
Config_addSpell2[1] = 60488             -- min range 45m, cast on tank -- Shadow Bolt (30)
Config_addSpell3[1] = 24326             -- min range 0m -- HIGH knockback (ZulFarrak beast)
Config_addSpell4[1] = 69898             -- cast on boss - Hot
Config_addSpellEnrage[1] = 69166        -- Enrage after 300 seconds

Config_addSpellTimer1[1] = 13000        -- This timer applies to Config_addSpell1
Config_addSpellTimer2[1] = 11000        -- This timer applies to Config_addSpell2
Config_addSpellTimer3[1] = 37000        -- This timer applies to Config_addSpell3
Config_addSpellTimer4[1] = 12000        -- This timer applies to Config_addSpell4

Config_addSpellModifier1bp0[1] = 500    -- not required if nil
Config_addSpellModifier1bp1[1] = nil    -- not required if nil
Config_addSpellModifier2bp0[1] = 2000   -- not required if nil
Config_addSpellModifier2bp1[1] = nil    -- not required if nil
Config_addSpellModifier3bp0[1] = nil    -- not required if nil
Config_addSpellModifier3bp1[1] = nil    -- not required if nil

Config_aura1Add1[1] = 34184             -- an aura to add to the 1st add-- Arcane
Config_aura2Add1[1] = 7941              -- another aura to add to the 1st add-- Nature
Config_aura1Add2[1] = 7942              -- an aura to add to the 2nd add-- Fire
Config_aura2Add2[1] = 7940              -- another aura to add to the 2nd add-- Frost
Config_aura1Add3[1] = 34182             -- an aura to add to the 3rd add-- Holy
Config_aura2Add3[1] = 34309             -- another aura to add to the 3rd add-- Shadow

Config_addSpell3Yell[1] = "Me smash."   -- yell for the adds when Spell 3 is cast
Config_addEnoughYell[1] = "ENOUGH"      -- yell for the add at 33% and 66% hp
Config_addEnoughSound[1] = 412          -- sound to play when the add is at 33% and 66%
Config_addSpell2Sound[1] = 6436         -- sound to play when add casts spell 2
--yell for the boss when all adds are dead
Config_bossYellPhase2[1] = "You might have handled these creatures. But now I WILL handle YOU!"
-- yell for the boss when they cast on themself
Config_bossSpellSelfYell[1] = nil

------------------------------------------
-- Begin of encounter 2 config
------------------------------------------

-- Database NPC entries. Must match the associated .sql file
Config_bossEntry[2] = 1112011           --db entry of the boss creature
Config_npcEntry[2] = 1112012            --db entry of the NPC creature to summon the boss
Config_addEntry[2] = 1112013            --db entry of the add creature
Config_npcText[2] = 91112               --gossip in npc_text to be told by the summoning NPC

-- list of spells:
Config_bossSpell1[2] = 33661            --directly applied to the tank-- Crush Armor: 10% reduction, stacks
Config_bossSpell2[2] = 51503            --randomly applied to a player in 35m range-- Domination
Config_bossSpell2MaxRange[2] = 35       --max range im m/y to check for targets for boss spell 2 (default 35)
Config_bossSpell3[2] = 35198            --on the 2nd nearest player within 30m-- AE fear
Config_bossSpell4[2] = 35198            --on a random player within 40m-- AE Fear
Config_bossSpell4Counter[2] = 1         --amount of casts to perform for spell 4. defaults to 1
Config_bossSpell4MaxRange[2] = 40       --max range im m to check for targets for boss spell 4 (default 40)
Config_bossSpell5[2] = nil              --this line is not neccesary. If a spell is missing it will just be skipped
Config_bossSpell6[2] = 31436            --directly applied to the tank when adds are dead
Config_bossSpellSelf[2] = nil           --cast on boss while adds are still alive
Config_bossSpellEnrage[2] = 54356       --cast on boss once after Config_bossSpellEnrageTimer ms have passed-- Soft Enrage

Config_bossSpellTimer1[2] = 10000       -- This timer applies to Config_bossSpell1
Config_bossSpellTimer2[2] = 23000       -- This timer applies to Config_bossSpell2
Config_bossSpellTimer3[2] = 29000       -- This timer applies to Config_bossSpellSelf in phase 1 and Config_bossSpell3+4 randomly later
Config_bossSpellTimer5[2] = 19000       -- This timer applies to Config_bossSpell5+6
Config_bossSpellEnrageTimer[2] = 300000

Config_addHealthModifierParty[2] = 1    -- modifier to change health for party encounter. Value in the SQL applies for raid
Config_addsAmount[2] = 2                -- how many adds will spawn

Config_addSpell1[2] = 10150             -- min range 30m, 1-3rd farthest target within 30m
Config_addSpell2[2] = 37704             -- min range 45m, cast on tank
Config_addSpell3[2] = 68958             -- min range 0m -- Blast Nova
Config_addSpell4[2] = 69389             -- cast on the boss
Config_addSpellEnrage[2] = nil          -- Enrage after 300 seconds

Config_addSpellTimer1[2] = 13000        -- This timer applies to Config_addSpell1
Config_addSpellTimer2[2] = 11000        -- This timer applies to Config_addSpell2
Config_addSpellTimer3[2] = 37000        -- This timer applies to Config_addSpell3
Config_addSpellTimer4[2] = 23000        -- This timer applies to Config_addSpell4

Config_aura1Add1[2] = nil               -- an aura to add to the 1st add--
Config_aura2Add1[2] = nil               -- another aura to add to the 1st add--
Config_aura1Add2[2] = nil               -- an aura to add to the 2nd add--
Config_aura2Add2[2] = nil               -- another aura to add to the 2nd add--
Config_aura1Add3[2] = nil               -- an aura to add to all ads from the 3rd on--
Config_aura2Add3[2] = nil               -- another aura to add to all add from the 3rd on--

Config_addSpell3Yell[2] = "Thissss."    -- yell for the adds when Spell 3 is cast
Config_addEnoughYell[2] = "Ssssssuffer!"-- yell for the add at 33% and 66% hp
Config_addEnoughSound[2] = 412          -- sound to play when the add is at 33% and 66%
Config_addSpell2Sound[2] = 6436         -- sound to play when add casts spell 2
--yell for the boss when all adds are dead
Config_bossYellPhase2[2] = "Now. You. Die."
-- yell for the boss when they cast on themself
Config_bossSpellSelfYell[2] = nil

------------------------------------------
-- Begin of encounter 3 config
------------------------------------------

-- Database NPC entries. Must match the associated .sql file
Config_bossEntry[3] = 1112021           --db entry of the boss creature
Config_npcEntry[3] = 1112022            --db entry of the NPC creature to summon the boss
Config_addEntry[3] = 1112023            --db entry of the add creature
Config_npcText[3] = 91113               --gossip in npc_text to be told by the summoning NPC

-- list of spells:
Config_bossSpell1[3] = nil              --directly applied to the tank--
Config_bossSpell2[3] = 56909            --randomly applied to a player in 35m range-- Cleave, up to 10 targets
Config_bossSpell2MaxRange[3] = 5        --max range im m/y to check for targets for boss spell 2 (default 35)
Config_bossSpell3[3] = nil              --on the 2nd nearest player within 30m--
Config_bossSpell4[3] = 11446            --on a random player within 40m-- 5min domination
Config_bossSpell4Counter[3] = 1         --amount of casts to perform for spell 4. defaults to 1
Config_bossSpell4MaxRange[3] = 40       --max range im m to check for targets for boss spell 4 (default 40)
Config_bossSpell5[3] = 22643            --directly applied to the tank with adds alive --volley
Config_bossSpell6[3] = 22643            --directly applied to the tank when adds are dead --volley
Config_bossSpellSelf[3] = 55948         --cast on boss while adds are still alive
Config_bossSpellEnrage[3] = 54356       --cast on boss once after Config_bossSpellEnrageTimer ms have passed-- Soft Enrage

Config_bossSpellTimer1[3] = 10000       -- This timer applies to Config_bossSpell1
Config_bossSpellTimer2[3] = 23000       -- This timer applies to Config_bossSpell2
Config_bossSpellTimer3[3] = 29000       -- This timer applies to Config_bossSpellSelf in phase 1 and Config_bossSpell3+4 randomly later
Config_bossSpellTimer5[3] = 19000       -- This timer applies to Config_bossSpell5+6
Config_bossSpellEnrageTimer[3] = 300000

Config_addHealthModifierParty[3] = 3    -- modifier to change health for party encounter. Value in the SQL applies for raid
Config_addsAmount[3] = 8                -- how many adds will spawn

Config_addSpell1[3] = 29320             -- min range 30m, 1-3rd farthest target within 30m -- charge
Config_addSpell2[3] = nil               -- min range 45m, cast on tank
Config_addSpell3[3] = 23105             -- min range 0m -- Lightning cloud
Config_addSpell4[3] = nil               -- cast on the boss
Config_addSpellEnrage[3] = nil          -- Enrage after 300 seconds

Config_addSpellTimer1[3] = 37000        -- This timer applies to Config_addSpell1
Config_addSpellTimer2[3] = nil          -- This timer applies to Config_addSpell2
Config_addSpellTimer3[3] = 37000        -- This timer applies to Config_addSpell3
Config_addSpellTimer4[3] = nil          -- This timer applies to Config_addSpell4

Config_aura1Add1[3] = nil               -- an aura to add to the 1st add--
Config_aura2Add1[3] = nil               -- another aura to add to the 1st add--
Config_aura1Add2[3] = nil               -- an aura to add to the 2nd add--
Config_aura2Add2[3] = nil               -- another aura to add to the 2nd add--
Config_aura1Add3[3] = nil               -- an aura to add to all ads from the 3rd on--
Config_aura2Add3[3] = nil               -- another aura to add to all add from the 3rd on--

Config_addSpell3Yell[3] = "Mmmrrrrrrrr."-- yell for the adds when Spell 3 is cast
Config_addEnoughYell[3] = "Rooooaaar"   -- yell for the add at 33% and 66% hp
Config_addEnoughSound[3] = 412          -- sound to play when the add is at 33% and 66%
Config_addSpell2Sound[3] = 6436         -- sound to play when add casts spell 2
--yell for the boss when all adds are dead
Config_bossYellPhase2[3] = " I'll git ye!"
-- yell for the boss when they cast on themself
Config_bossSpellSelfYell[3] = "Yous Minions be feeding me all ya Strength!"

------------------------------------------
-- Begin of encounter 4 config
------------------------------------------

-- Database NPC entries. Must match the associated .sql file
Config_bossEntry[4] = 1112031           --db entry of the boss creature
Config_npcEntry[4] = 1112032            --db entry of the NPC creature to summon the boss
Config_addEntry[4] = 1112033            --db entry of the add creature
Config_npcText[4] = 91114               --gossip in npc_text to be told by the summoning NPC

-- list of spells:
Config_bossSpell1[4] = nil              --directly applied to the tank--
Config_bossSpell2[4] = 56909            --randomly applied to a player in [Config_bossSpell2MaxRange] meters-- Cleave, up to 10 targets
Config_bossSpell2MaxRange[4] = 5        --max range im m/y to check for targets for boss spell 2 (default 35)
Config_bossSpell3[4] = 19717            --on the 2nd nearest player within 30m-- fire rain
Config_bossSpell4[4] = 11446            --on a random player within 40m-- 5min domination
Config_bossSpell4Counter[4] = 1         --amount of casts to perform for spell 4. defaults to 1
Config_bossSpell4MaxRange[4] = 40       --max range im m to check for targets for boss spell 4 (default 40)
Config_bossSpell5[4] = 22643            --directly applied to the tank with adds alive --volley
Config_bossSpell6[4] = 22643            --directly applied to the tank when adds are dead --volley
Config_bossSpell7[4] = nil              --directly applied to the tank
Config_bossSpell8[4] = nil              --directly applied to the tank x seconds after spell 7
Config_bossSpellSelf[4] = 55948         --cast on boss while adds are still alive
Config_bossSpellEnrage[4] = 54356       --cast on boss once after Config_bossSpellEnrageTimer ms have passed-- Soft Enrage

Config_bossSpellTimer1[4] = 10000       -- This timer applies to Config_bossSpell1
Config_bossSpellTimer2[4] = 23000       -- This timer applies to Config_bossSpell2
Config_bossSpellTimer3[4] = 29000       -- This timer applies to Config_bossSpellSelf in phase 1 and Config_bossSpell3+4 randomly later
Config_bossSpellTimer5[4] = 19000       -- This timer applies to Config_bossSpell5+6
Config_bossSpellTimer7[4] = nil         -- This timer applies to Config_bossSpell7+8
Config_bossSpell8delay[4] = nil         -- Delay between spell 7 and 8. Must be smaller than timer7 / 2
Config_bossSpellEnrageTimer[4] = 300000

Config_bossSpellModifier1bp0[4] = 35       -- base damage of the Cleave
Config_bossSpellModifier1bp1[4] = nil      -- not required if nil
Config_bossSpellModifier2bp0[4] = nil      -- not required if nil
Config_bossSpellModifier2bp1[4] = nil      -- not required if nil
Config_bossSpellModifier3bp0[4] = 800      -- base damage of the fire rain
Config_bossSpellModifier3bp1[4] = nil      -- not required if nil
Config_bossSpellModifier4bp0[4] = nil      -- not required if nil
Config_bossSpellModifier4bp1[4] = nil      -- not required if nil
Config_bossSpellModifier5bp0[4] = 250      -- base damage for the Frostbolt Volley in P1
Config_bossSpellModifier5bp1[4] = nil      -- not required if nil
Config_bossSpellModifier6bp0[4] = 400      -- base damage for the Frostbolt Volley in P2
Config_bossSpellModifier6bp1[4] = nil      -- not required if nil
Config_bossSpellModifier7bp0[4] = nil      -- not required if nil
Config_bossSpellModifier7bp1[4] = nil      -- not required if nil
Config_bossSpellModifier8bp0[4] = nil      -- not required if nil
Config_bossSpellModifier8bp1[4] = nil      -- not required if nil

Config_addHealthModifierParty[4] = 3    -- modifier to change health for party encounter. Value in the SQL applies for raid
Config_addsAmount[4] = 8                -- how many adds will spawn

Config_addSpell1[4] = 29320             -- min range 30m, 1-3rd farthest target within 30m --charge
Config_addSpell2[4] = nil               -- min range 45m, cast on tank
Config_addSpell3[4] = 23105             -- min range 0m -- lightning cloud
Config_addSpell4[4] = 69898             -- cast on the boss -- hot
Config_addSpellEnrage[4] = nil          -- Enrage after 300 seconds

Config_addSpellTimer1[4] = 37000        -- This timer applies to Config_addSpell1
Config_addSpellTimer2[4] = nil          -- This timer applies to Config_addSpell2
Config_addSpellTimer3[4] = 37000        -- This timer applies to Config_addSpell3
Config_addSpellTimer4[4] = 12000        -- This timer applies to Config_addSpell4

Config_addSpellModifier1bp0[4] = nil    -- not required if nil
Config_addSpellModifier1bp1[4] = nil    -- not required if nil
Config_addSpellModifier2bp0[4] = nil    -- not required if nil
Config_addSpellModifier2bp1[4] = nil    -- not required if nil
Config_addSpellModifier3bp0[4] = 500    -- Initial damage of Lightning Cloud
Config_addSpellModifier3bp1[4] = 1000   -- Tick damage of Lightning Cloud

Config_aura1Add1[4] = 42375             -- an aura to add to the 1st add-- AE heal
Config_aura2Add1[4] = nil               -- another aura to add to the 1st add--
Config_aura1Add2[4] = 42375             -- an aura to add to the 2nd add-- AE heal
Config_aura2Add2[4] = nil               -- another aura to add to the 2nd add--
Config_aura1Add3[4] = 42375             -- an aura to add to all ads from the 3rd on-- AE heal
Config_aura2Add3[4] = nil               -- another aura to add to all add from the 3rd on--

Config_addSpell3Yell[4] = "Mmmrrrrrrrr."-- yell for the adds when Spell 3 is cast
Config_addEnoughYell[4] = "Rooooaaar"   -- yell for the add at 33% and 66% hp
Config_addEnoughSound[4] = 412          -- sound to play when the add is at 33% and 66%
Config_addSpell2Sound[4] = 6436         -- sound to play when add casts spell 2
--yell for the boss when all adds are dead
Config_bossYellPhase2[4] = " I'll git ye!"
-- yell for the boss when they cast on themself
Config_bossSpellSelfYell[4] = "Yous Minions be feeding me all ya Strength!"

------------------------------------------
-- Begin of encounter 5 config
------------------------------------------

-- Database NPC entries. Must match the associated .sql file
Config_bossEntry[5] = 1112041           --db entry of the boss creature
Config_npcEntry[5] = 1112042            --db entry of the NPC creature to summon the boss
Config_addEntry[5] = 1112043            --db entry of the add creature
Config_npcText[5] = 91115               --gossip in npc_text to be told by the summoning NPC

-- list of spells:
Config_bossSpell1[5] = nil              --directly applied to the tank--
Config_bossSpell2[5] = 56909            --randomly applied to a player in 35m range-- Cleave, up to 10 targets
Config_bossSpell2MaxRange[5] = 5        --max range im m/y to check for targets for boss spell 2 (default 35)
Config_bossSpell3[5] = 19717            --on the 2nd nearest player within 30m--
Config_bossSpell4[5] = 11446            --on a random player within 40m-- 5min domination
Config_bossSpell4Counter[5] = 1         --amount of casts to perform for spell 4. defaults to 1
Config_bossSpell4MaxRange[5] = 40       --max range im m to check for targets for boss spell 4 (default 40)
Config_bossSpell5[5] = 22643            --directly applied to the tank with adds alive --volley
Config_bossSpell6[5] = 22643            --directly applied to the tank when adds are dead --volley
Config_bossSpell7[5] = 16805            --directly applied to the tank
Config_bossSpell8[5] = 16805            --directly applied to the tank x seconds after spell 7
Config_bossSpell8delay[5] = 6000        --delay between spell 7 and 8. Must be smaller than timer7 / 2
Config_bossSpellSelf[5] = 55948         --cast on boss while adds are still alive
Config_bossSpellEnrage[5] = 54356       --cast on boss once after Config_bossSpellEnrageTimer ms have passed-- Soft Enrage

Config_bossSpellTimer1[5] = 10000       -- This timer applies to Config_bossSpell1
Config_bossSpellTimer2[5] = 23000       -- This timer applies to Config_bossSpell2
Config_bossSpellTimer3[5] = 29000       -- This timer applies to Config_bossSpellSelf in phase 1 and Config_bossSpell3+4 randomly later
Config_bossSpellTimer5[5] = 19000       -- This timer applies to Config_bossSpell5+6
Config_bossSpellTimer7[5] = 18000       -- This timer applies to Config_bossSpell7+8 (in ms)
Config_bossSpellEnrageTimer[5] = 300000

Config_bossSpellModifier1bp0[5] = 35       -- base damage of the Cleave
Config_bossSpellModifier1bp1[5] = nil      -- not required if nil
Config_bossSpellModifier2bp0[5] = nil      -- not required if nil
Config_bossSpellModifier2bp1[5] = nil      -- not required if nil
Config_bossSpellModifier3bp0[5] = 800      -- base damage of the fire rain
Config_bossSpellModifier3bp1[5] = nil      -- not required if nil
Config_bossSpellModifier4bp0[5] = nil      -- not required if nil
Config_bossSpellModifier4bp1[5] = nil      -- not required if nil
Config_bossSpellModifier5bp0[5] = 250      -- base damage for the Frostbolt Volley in P1
Config_bossSpellModifier5bp1[5] = nil      -- not required if nil
Config_bossSpellModifier6bp0[5] = 400      -- base damage for the Frostbolt Volley in P2
Config_bossSpellModifier6bp1[5] = nil      -- not required if nil
Config_bossSpellModifier7bp0[5] = nil      -- not required if nil
Config_bossSpellModifier7bp1[5] = nil      -- not required if nil
Config_bossSpellModifier8bp0[5] = nil      -- not required if nil
Config_bossSpellModifier8bp1[5] = nil      -- not required if nil

Config_addHealthModifierParty[5] = 2    -- modifier to change health for party encounter. Value in the SQL applies for raid
Config_addsAmount[5] = 6                -- how many adds will spawn

Config_addSpell1[5] = 29320             -- min range 30m, 1-3rd farthest target within 30m -- charge
Config_addSpell2[5] = nil               -- min range 45m, cast on tank
Config_addSpell3[5] = 23105             -- min range 0m -- Lightning cloud
Config_addSpell4[5] = 69898             -- cast on the boss
Config_addSpellEnrage[5] = nil          -- Enrage after 300 seconds

Config_addSpellTimer1[5] = 37000        -- This timer applies to Config_addSpell1
Config_addSpellTimer2[5] = nil          -- This timer applies to Config_addSpell2
Config_addSpellTimer3[5] = 37000        -- This timer applies to Config_addSpell3
Config_addSpellTimer4[5] = 12000        -- This timer applies to Config_addSpell4

Config_addSpellModifier1bp0[5] = nil    -- not required if nil
Config_addSpellModifier1bp1[5] = nil    -- not required if nil
Config_addSpellModifier2bp0[5] = nil    -- not required if nil
Config_addSpellModifier2bp1[5] = nil    -- not required if nil
Config_addSpellModifier3bp0[5] = 400    -- Initial damage of Lightning Cloud
Config_addSpellModifier3bp1[5] = 1200   -- Tick damage of Lightning Cloud

Config_aura1Add1[5] = 42375             -- an aura to add to the 1st add-- AE heal
Config_aura2Add1[5] = nil               -- another aura to add to the 1st add--
Config_aura1Add2[5] = 42375             -- an aura to add to the 2nd add-- AE heal
Config_aura2Add2[5] = nil               -- another aura to add to the 2nd add--
Config_aura1Add3[5] = 42375             -- an aura to add to all ads from the 3rd on-- AE heal
Config_aura2Add3[5] = nil               -- another aura to add to all add from the 3rd on--

Config_addSpell3Yell[5] = "Mmmrrrrrrrr."-- yell for the adds when Spell 3 is cast
Config_addEnoughYell[5] = "Rooooaaar"   -- yell for the add at 33% and 66% hp
Config_addEnoughSound[5] = 412          -- sound to play when the add is at 33% and 66%
Config_addSpell2Sound[5] = 6436         -- sound to play when add casts spell 2
--yell for the boss when all adds are dead
Config_bossYellPhase2[5] = " I'll git ye!"
-- yell for the boss when they cast on themself
Config_bossSpellSelfYell[5] = "Yous Minions be feeding me all ya Strength!"

------------------------------------------
-- Begin of encounter 6 config
------------------------------------------

-- Database NPC entries. Must match the associated .sql file
Config_bossEntry[6] = 1112051           --db entry of the boss creature
Config_npcEntry[6] = 1112052            --db entry of the NPC creature to summon the boss
Config_addEntry[6] = 1112053            --db entry of the add creature
Config_npcText[6] = 91116               --gossip in npc_text to be told by the summoning NPC

-- list of spells:
Config_bossSpell1[6] = 15283            --directly applied to the tank-- 8second stun
Config_bossSpell2[6] = 25034            --randomly applied to a player in 35m range-- Forked Lightning
Config_bossSpell2MaxRange[6] = 30       --max range im m/y to check for targets for boss spell 2 (default 35)
Config_bossSpell3[6] = 25021            --on the 2nd nearest player within 30m-- Chain Lightning
Config_bossSpell4[6] = 11446            --on a random player within 40m-- 5min domination
Config_bossSpell4Counter[6] = 1         --amount of casts to perform for spell 4. defaults to 1
Config_bossSpell4MaxRange[6] = 40       --max range im m to check for targets for boss spell 4 (default 40)
Config_bossSpell5[6] = nil              --directly applied to the tank with adds alive --volley
Config_bossSpell6[6] = nil              --directly applied to the tank when adds are dead --volley
Config_bossSpell7[6] = 37106            --directly applied to the tank - Charged Arcane Explosion
Config_bossSpell8[6] = 43648            --directly applied to the tank x seconds after spell 7 - Electrical Storm
Config_bossSpell8delay[6] = 8000        --delay between spell 7 and 8. Must be smaller than timer7 / 2
Config_bossSpellSelf[6] = 67973         --cast on boss while adds are still alive (Rejuvenation)
Config_bossSpellEnrage[6] = 54356       --cast on boss once after Config_bossSpellEnrageTimer ms have passed-- Soft Enrage

Config_bossSpellTimer1[6] = 10000       -- This timer applies to Config_bossSpell1
Config_bossSpellTimer2[6] = 23000       -- This timer applies to Config_bossSpell2
Config_bossSpellTimer3[6] = 29000       -- This timer applies to Config_bossSpellSelf in phase 1 and Config_bossSpell3+4 randomly later
Config_bossSpellTimer5[6] = 19000       -- This timer applies to Config_bossSpell5+6
Config_bossSpellTimer7[6] = 22000       -- This timer applies to Config_bossSpell7+8 (in ms)
Config_bossSpellEnrageTimer[6] = 300000
Config_minPhaseForTimer7[6] = 2         -- From this phase on the boss will use Timer 7 to cast Spell 7+8. Will ignore it before.

Config_bossSpellModifier1bp0[6] = nil      -- not required if nil
Config_bossSpellModifier1bp1[6] = nil      -- not required if nil
Config_bossSpellModifier2bp0[6] = 1000     -- base damage of the forked lightning
Config_bossSpellModifier2bp1[6] = nil      -- not required if nil
Config_bossSpellModifier3bp0[6] = 800      -- base damage of the Chain Lightning
Config_bossSpellModifier3bp1[6] = nil      -- not required if nil
Config_bossSpellModifier4bp0[6] = nil      -- not required if nil
Config_bossSpellModifier4bp1[6] = nil      -- not required if nil
Config_bossSpellModifier5bp0[6] = nil      -- not required if nil
Config_bossSpellModifier5bp1[6] = nil      -- not required if nil
Config_bossSpellModifier6bp0[6] = nil      -- not required if nil
Config_bossSpellModifier6bp1[6] = nil      -- not required if nil
Config_bossSpellModifier7bp0[6] = 500      -- base damage for Charged Arcane Explosion
Config_bossSpellModifier7bp1[6] = nil      -- not required if nil
Config_bossSpellModifier8bp0[6] = nil      -- not required if nil
Config_bossSpellModifier8bp1[6] = nil      -- not required if nil

Config_addHealthModifierParty[6] = 0.2     -- modifier to change health for party encounter. Value in the SQL applies for raid
Config_addsAmount[6] = 2                   -- how many adds will spawn

Config_addSpell1[6] = 28884             -- min range 30m, 1-3rd farthest target within 30m -- Meteor
Config_addSpell2[6] = 19630             -- min range 45m, cast on tank -- Cone of Fire
Config_addSpell3[6] = 13808             -- min range 0m -- Grenade
Config_addSpell4[6] = 67973             -- cast on the boss (Rejuvenation)
Config_addSpellEnrage[6] = nil          -- Enrage after 300 seconds

Config_addSpellTimer1[6] = 37000        -- This timer applies to Config_addSpell1
Config_addSpellTimer2[6] = 13000        -- This timer applies to Config_addSpell2
Config_addSpellTimer3[6] = 7000         -- This timer applies to Config_addSpell3
Config_addSpellTimer4[6] = 12000        -- This timer applies to Config_addSpell4

Config_addSpellModifier1bp0[6] = nil    -- not required if nil
Config_addSpellModifier1bp1[6] = nil    -- not required if nil
Config_addSpellModifier2bp0[6] = nil    -- not required if nil
Config_addSpellModifier2bp1[6] = nil    -- not required if nil
Config_addSpellModifier3bp0[6] = 1000    -- not required if nil
Config_addSpellModifier3bp1[6] = nil    -- not required if nil

Config_aura1Add1[6] = 13022             -- an aura to add to the 1st add-- Fire and Arcane Reflect
Config_aura2Add1[6] = 19595             -- another aura to add to the 1st add-- Shadow and Frost Reflect
Config_aura1Add2[6] = 25777             -- an aura to add to the 2nd add-- Thorns
Config_aura2Add2[6] = nil               -- another aura to add to the 2nd add--
Config_aura1Add3[6] = nil               -- an aura to add to all ads from the 3rd on-- Fiery Aura
Config_aura2Add3[6] = nil               -- another aura to add to all add from the 3rd on--

Config_addSpell3Yell[6] = "Die, Insect."-- yell for the adds when Spell 3 is cast
Config_addEnoughYell[6] = "Feel my Wrath!"   -- yell for the add at 33% and 66% hp
Config_addEnoughSound[6] = 412          -- sound to play when the add is at 33% and 66%
Config_addSpell2Sound[6] = 6436         -- sound to play when add casts spell 2
--yell for the boss when all adds are dead
Config_bossYellPhase2[6] = "Bee bop. Reconfiguring!"
-- yell for the boss when they cast on themself
Config_bossSpellSelfYell[6] = "Adjusting Defenses. Stand back."

------------------------------------------
-- Begin of encounter 7 config
------------------------------------------

-- Database NPC entries. Must match the associated .sql file
Config_bossEntry[7] = 1112061           --db entry of the boss creature
Config_npcEntry[7] = 1112062            --db entry of the NPC creature to summon the boss
Config_addEntry[7] = 1112063            --db entry of the add creature
Config_npcText[7] = 91117               --gossip in npc_text to be told by the summoning NPC

-- list of spells:
Config_bossSpell1[7] = 15283            --directly applied to the tank-- 8second stun
Config_bossSpell2[7] = nil              --on a random player within Config_bossSpell2MaxRange
Config_bossSpell2MaxRange[7] = 50       --max range im m/y to check for targets for boss spell 2 (default 35)
Config_bossSpell3[7] = 29484            --on the 2nd nearest player within 30m -- Web Spray
Config_bossSpell4[7] = 59108            --on a random player within Config_bossSpell4MaxRange -- Glutinous Poison
Config_bossSpell4Counter[7] = 10        --amount of casts to perform for spell 4. defaults to 1
Config_bossSpell4MaxRange[7] = 30       --max range im m to check for targets for boss spell 4 (default 40)
Config_bossSpell5[7] = 28741            --directly applied to the tank with adds alive --poison cone
Config_bossSpell6[7] = 28741            --directly applied to the tank when adds are dead --poison cone
Config_bossSpell7[7] = nil              --directly applied to the tank -
Config_bossSpell8[7] = nil              --directly applied to the tank x seconds after spell 7 -
Config_bossSpell8delay[7] = nil         --delay between spell 7 and 8. Must be smaller than timer7 / 2
Config_bossSpellSelf[7] = 19712         --cast on boss while adds are still alive (Arcane Explosion)
Config_bossSpellEnrage[7] = 54356       --cast on boss once after Config_bossSpellEnrageTimer ms have passed-- Soft Enrage

Config_bossSpellTimer1[7] = 10000       -- This timer applies to Config_bossSpell1
Config_bossSpellTimer2[7] = 37000       -- This timer applies to Config_bossSpell2
Config_bossSpellTimer3[7] = 29000       -- This timer applies to Config_bossSpellSelf in phase 1 and Config_bossSpell3+4 randomly later
Config_bossSpellTimer5[7] = 19000       -- This timer applies to Config_bossSpell5+6
Config_bossSpellTimer7[7] = 22000       -- This timer applies to Config_bossSpell7+8 (in ms)
Config_bossSpellEnrageTimer[7] = 90000
Config_minPhaseForTimer7[7] = 3         -- From this phase on the boss will use Timer 7 to cast Spell 7+8. Will ignore it before.

Config_bossSpellModifier1bp0[7] = nil      -- not required if nil
Config_bossSpellModifier1bp1[7] = nil      -- not required if nil
Config_bossSpellModifier2bp0[7] = nil      -- not required if nil
Config_bossSpellModifier2bp1[7] = nil      -- not required if nil
Config_bossSpellModifier3bp0[7] = nil      -- not required if nil
Config_bossSpellModifier3bp1[7] = 250      -- web spray damage
Config_bossSpellModifier4bp0[7] = 1000     -- base damage of Glutinous Poison
Config_bossSpellModifier4bp1[7] = nil      -- not required if nil
Config_bossSpellModifier5bp0[7] = 750      -- base damage of poison cone
Config_bossSpellModifier5bp1[7] = nil      -- not required if nil
Config_bossSpellModifier6bp0[7] = 1500     -- base damage of poison cone
Config_bossSpellModifier6bp1[7] = nil      -- not required if nil
Config_bossSpellModifier7bp0[7] = nil      -- not required if nil
Config_bossSpellModifier7bp1[7] = nil      -- not required if nil
Config_bossSpellModifier8bp0[7] = nil      -- not required if nil
Config_bossSpellModifier8bp1[7] = nil      -- not required if nil

Config_addHealthModifierParty[7] = 0.2     -- modifier to change health for party encounter. Value in the SQL applies for raid
Config_addsAmount[7] = 4                   -- how many adds will spawn

Config_addSpell1[7] = 12421             -- min range 30m, 1-3rd farthest target within 30m -- Mithril Grenade
Config_addSpell2[7] = 23105             -- min range 45m, cast on tank
Config_addSpell3[7] = nil               -- min range 0m
Config_addSpell4[7] = 67891             -- cast on the boss (Direct full heal)
Config_addSpellEnrage[7] = nil          -- Enrage after 300 seconds

Config_addSpellTimer1[7] = 23000        -- This timer applies to Config_addSpell1
Config_addSpellTimer2[7] = 13000        -- This timer applies to Config_addSpell2
Config_addSpellTimer3[7] = 7000         -- This timer applies to Config_addSpell3
Config_addSpellTimer4[7] = 12000        -- This timer applies to Config_addSpell4

Config_addSpellModifier1bp0[7] = 714    -- not required if nil
Config_addSpellModifier1bp1[7] = nil    -- not required if nil
Config_addSpellModifier2bp0[7] = 500    -- not required if nil
Config_addSpellModifier2bp1[7] = 1000   -- not required if nil
Config_addSpellModifier3bp0[7] = 1000   -- not required if nil
Config_addSpellModifier3bp1[7] = nil    -- not required if nil

Config_aura1Add1[7] = 13022             -- an aura to add to the 1st add-- Fire and Arcane Reflect
Config_aura2Add1[7] = 19595             -- another aura to add to the 1st add-- Shadow and Frost Reflect
Config_aura1Add2[7] = 25777             -- an aura to add to the 2nd add--  Fire and Arcane Reflect
Config_aura2Add2[7] = 19595             -- another aura to add to the 2nd add -- Shadow and Frost Reflect
Config_aura1Add3[7] = 25777             -- an aura to add to all ads from the 3rd on-- Thorns
Config_aura2Add3[7] = nil               -- another aura to add to all add from the 3rd on--

Config_addSpell3Yell[7] = "Bow to your gods!"-- yell for the adds when Spell 3 is cast
Config_addEnoughYell[7] = "Feel my Wrath!"   -- yell for the add at 33% and 66% hp
Config_addEnoughSound[7] = 6763         -- sound to play when the add is at 33% and 66%
Config_addSpell2Sound[7] = 721          -- sound to play when add casts spell 2
--yell for the boss when all adds are dead
Config_bossYellPhase2[7] = "Sssssszzzzzzzzz!"
-- yell for the boss when they cast on themself
Config_bossSpellSelfYell[7] = "SSSSSSSUFfffrrrrr!"


------------------------------------------
-- End of encounter 7
------------------------------------------

-- these are the fireworks to be cast randomly for 20s when an encounter was beaten
Config_fireworks[1] = 66400
Config_fireworks[2] = 66402
Config_fireworks[3] = 46847
Config_fireworks[4] = 46829
Config_fireworks[5] = 46830
Config_fireworks[6] = 62074
Config_fireworks[7] = 62075
Config_fireworks[8] = 62077
Config_fireworks[9] = 55420

------------------------------------------
-- NO ADJUSTMENTS REQUIRED BELOW THIS LINE
------------------------------------------

--constants
local PLAYER_EVENT_ON_LOGOUT = 4            -- (event, player)
local PLAYER_EVENT_ON_REPOP = 35            -- (event, player)
local PLAYER_EVENT_ON_COMMAND = 42          -- (event, player, command) - player is nil if command used from console. Can return false
local TEMPSUMMON_MANUAL_DESPAWN = 8         -- despawns when UnSummon() is called
local GOSSIP_EVENT_ON_HELLO = 1             -- (event, player, object) - Object is the Creature/GameObject/Item. Can return false to do default action. For item gossip can return false to stop spell casting.
local GOSSIP_EVENT_ON_SELECT = 2            -- (event, player, object, sender, intid, code, menu_id)
local OPTION_ICON_CHAT = 0
local OPTION_ICON_BATTLE = 9

local SELECT_TARGET_RANDOM = 0              -- Just selects a random target
local SELECT_TARGET_TOPAGGRO = 1            -- Selects targets from top aggro to bottom
local SELECT_TARGET_BOTTOMAGGRO = 2         -- Selects targets from bottom aggro to top
local SELECT_TARGET_NEAREST = 3
local SELECT_TARGET_FARTHEST = 4

local PARTY_IN_PROGRESS = 1
local RAID_IN_PROGRESS = 2

local ELUNA_EVENT_ON_LUA_STATE_CLOSE = 16

--local variables
local cancelGossipEvent
local eventInProgress
local bossfightInProgress
local difficulty                            -- difficulty is set when using .startevent and it is meant for a range of 1-10
local addsDownCounter
local phase
local addphase
local x
local y
local z
local o
local spawnedBossGuid
local spawnedNPCGuid
local encounterStartTime
local mapEventStart
local npcObjectGuid
local partyNpcSayCounter = 0
local lastBossSpell1
local lastBossSpell2
local lastBossSpell3
local lastBossSpell5
local lastBossSpell7
local nextBossSpell8Delay
local lastBossSpellSelf
local lastAddSpell1 = {}
local lastAddSpell2 = {}
local lastAddSpell3 = {}
local lastAddSpell4 = {}
local partyEvent = {}                   -- selected boss per [accountId] for party only mode

--local arrays
local cancelEventIdHello = {}
local cancelEventIdStart = {}
local addNPC = {}
local bossNPC = {}
local playersInRaid = {}
local groupPlayers = {}
local playersForFireworks = {}
local spawnedCreatureGuid = {}
local scoreEarned = {}
local scoreTotal = {}

if Config.addEnoughSpell == nil then PrintError("customWorldboss.lua: Missing flag Config.addEnoughSpell.") end
if Config.customDbName == nil then PrintError("customWorldboss.lua: Missing flag Config.customDbName.") end
if Config.GMRankForEventStart == nil then PrintError("customWorldboss.lua: Missing flag Config.GMRankForEventStart.") end
if Config.GMRankForUpdateDB == nil then PrintError("customWorldboss.lua: Missing flag Config.GMRankForUpdateDB.") end
if Config.printErrorsToConsole == nil then PrintError("customWorldboss.lua: Missing flag Config.printErrorsToConsole.") end
if Config.addEnrageTimer == nil then PrintError("customWorldboss.lua: Missing flag Config.addEnrageTimer.") end

local function eS_has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

local function eS_returnIndex (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return index
        end
    end
    return false
end

local function newAutotable(dim)
    local MT = {};
    for i=1, dim do
        MT[i] = {__index = function(t, k)
            if i < dim then
                t[k] = setmetatable({}, MT[i+1])
                return t[k];
            end
        end}
    end

    return setmetatable({}, MT[1]);
end

local function eS_castFireworks(eventId, delay, repeats)
    local player
    for n, v in pairs(playersForFireworks) do
        player = GetPlayerByGUID(v)
        if player ~= nil then
            player:CastSpell(player, Config_fireworks[math.random(1, #Config_fireworks)])
        end
    end
    if repeats == 1 then
        playersForFireworks = {}
    end
end

local function eS_resetPlayers(event, player)
    if eS_has_value(playersInRaid, player:GetGUID()) and player:GetPhaseMask() ~= 1 then
        if player ~= nil then
            if player:GetCorpse() ~= nil then
                player:GetCorpse():SetPhaseMask(1)
            end
            player:SetPhaseMask(1)
            player:SendBroadcastMessage("You left the event.")
        end
    end
end

local function eS_getSize(difficulty)
    local value
    if difficulty == 1 then
        value = 1
    else
        value = 1 + (difficulty - 1) / 4
    end
    return value
end

local function eS_splitString(inputstr, seperator)
    if seperator == nil then
        seperator = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..seperator.."]+)") do
        table.insert(t, str)
    end
    return t
end

local function eS_checkInCombat()
    --check if all players are in combat
    local player
    for _, v in pairs(playersInRaid) do
        player = GetPlayerByGUID(v)
        if player ~= nil then
            if player:IsInCombat() == false and player:GetPhaseMask() == 2 then
                if player:GetCorpse() ~= nil then
                    player:GetCorpse():SetPhaseMask(1)
                end
                player:SetPhaseMask(1)
                player:SendBroadcastMessage("You were returned to the real time because you did not participate.")
            end
        end
    end
end

local function eS_getEncounterDuration()
    local dt = GetTimeDiff(encounterStartTime)
    return string.format("%.2d:%.2d", (dt / 1000 / 60) % 60, (dt / 1000) % 60)
end

local function eS_getTimeSince(time)
    if time then
        return GetTimeDiff(time)
    end
    return 0
end

local function eS_getDifficultyTimer(rawTimer)
    if difficulty == 1 then
        return rawTimer
    else
        local timer = rawTimer / (1 + ((difficulty - 1) / 9))
        return timer
    end
end

local function eS_getDifficultyModifier(base)
    if difficulty == 1 then
        return base
    else
        local modifier = base * (1 + ((difficulty - 1) / 9))
        return modifier
    end
end

local function eS_onHello(event, player, creature)
    if player == nil then return end
    if bossfightInProgress ~= nil then
        player:SendBroadcastMessage("Some heroes are still fighting the enemies of time since "..eS_getEncounterDuration())
        player:GossipMenuAddItem(OPTION_ICON_CHAT, "What's my score?", Config_npcEntry[eventInProgress], 0)
        player:GossipSendMenu(Config_npcText[eventInProgress], creature, 0)
        return
    end

    player:GossipMenuAddItem(OPTION_ICON_CHAT, "What's my score?", Config_npcEntry[eventInProgress], 0)
    player:GossipMenuAddItem(OPTION_ICON_CHAT, "We are ready to fight a servant!", Config_npcEntry[eventInProgress], 1)
    player:GossipMenuAddItem(OPTION_ICON_CHAT, "We brought the best there is and we're ready for anything.", Config_npcEntry[eventInProgress], 2)
    player:GossipSendMenu(Config_npcText[eventInProgress], creature, 0)
end

local function eS_onPartyOnlyHello(event, player, creature)
    if player == nil then return end
    if bossfightInProgress ~= nil then
        player:SendBroadcastMessage("Some heroes are still fighting the enemies of time since "..eS_getEncounterDuration())
        player:GossipMenuAddItem(OPTION_ICON_CHAT, "What's my score?", Config.partySelectNpc, 0)
        player:GossipSendMenu(Config.defaultNpcText1, creature, 0)
        return
    end

    player:GossipMenuAddItem(OPTION_ICON_CHAT, "What's my score?", Config.partySelectNpc, 0)
    player:GossipMenuAddItem(OPTION_ICON_CHAT, "Let us fight a servant! (Difficulty 1)", Config.partySelectNpc, 1)
    player:GossipMenuAddItem(OPTION_ICON_CHAT, "Let us fight a servant! (Difficulty 2)", Config.partySelectNpc, 2)
    player:GossipMenuAddItem(OPTION_ICON_CHAT, "Let us fight a servant! (Difficulty 3)", Config.partySelectNpc, 3)
    player:GossipMenuAddItem(OPTION_ICON_CHAT, "Let us fight a servant! (Difficulty 4)", Config.partySelectNpc, 4)
    player:GossipMenuAddItem(OPTION_ICON_CHAT, "Let us fight a servant! (Difficulty 5)", Config.partySelectNpc, 5)
    player:GossipMenuAddItem(OPTION_ICON_CHAT, "Let us fight a servant! (Difficulty 6)", Config.partySelectNpc, 6)
    player:GossipMenuAddItem(OPTION_ICON_CHAT, "Let us fight a servant! (Difficulty 7)", Config.partySelectNpc, 7)
    player:GossipMenuAddItem(OPTION_ICON_CHAT, "Let us fight a servant! (Difficulty 8)", Config.partySelectNpc, 8)
    player:GossipMenuAddItem(OPTION_ICON_CHAT, "Let us fight a servant! (Difficulty 9)", Config.partySelectNpc, 9)
    player:GossipMenuAddItem(OPTION_ICON_CHAT, "Let us fight a servant! (Difficulty 10)", Config.partySelectNpc, 10)
    player:GossipSendMenu(Config.defaultNpcText1, creature, 0)
end

local function awardScore()
    local score = Config.baseScore + (Config.additionalScore * difficulty)
    for _, playerGuid in pairs(playersInRaid) do
        if  GetPlayerByGUID(playerGuid) ~= nil then
            local accountId = GetPlayerByGUID(playerGuid):GetAccountId()
            if scoreEarned[accountId] == nil then scoreEarned[accountId] = 0 end
            if scoreTotal[accountId] == nil then scoreTotal[accountId] = 0 end
            scoreEarned[accountId] = scoreEarned[accountId] + score
            scoreTotal[accountId] = scoreTotal[accountId] + score
            CharDBExecute('REPLACE INTO `'..Config.customDbName..'`.`eventscript_score` VALUES ('..accountId..', '..scoreEarned[accountId]..', '..scoreTotal[accountId]..');');
            local gameTime = (tonumber(tostring(GetGameTime())))
            local playerLowGuid = GetGUIDLow(playerGuid)
            CharDBExecute('INSERT IGNORE INTO `'..Config.customDbName..'`.`eventscript_encounters` VALUES ('..gameTime..', '..playerLowGuid..', '..eventInProgress..', '..difficulty..', '..bossfightInProgress..', '..eS_getTimeSince(encounterStartTime)..');');
        end
    end
    bossfightInProgress = nil
end

local function storeEncounter()
    for _, playerGuid in pairs(playersInRaid) do
        if  GetPlayerByGUID(playerGuid) ~= nil then
            local accountId = GetPlayerByGUID(playerGuid):GetAccountId()
            local gameTime = (tonumber(tostring(GetGameTime())))
            local playerLowGuid = GetGUIDLow(playerGuid)
            CharDBExecute('INSERT IGNORE INTO `'..Config.customDbName..'`.`eventscript_encounters` VALUES ('..gameTime..', '..playerLowGuid..', '..eventInProgress..', '..difficulty..', '..bossfightInProgress..', '..eS_getTimeSince(encounterStartTime)..');');
        end
    end
    bossfightInProgress = nil
end

local function eS_chromieGossip(event, player, object, sender, intid, code, menu_id)
    local spawnedBoss
    local spawnedCreature = {}

    if player == nil then return end

    local group = player:GetGroup()

    if intid == 0 then
        local accountId = player:GetAccountId()
        if scoreEarned[accountId] == nil then scoreEarned[accountId] = 0 end
        if scoreTotal[accountId] == nil then scoreTotal[accountId] = 0 end
        player:SendBroadcastMessage("Your current event score is: "..scoreEarned[accountId].." and your all-time event score is: "..scoreTotal[accountId])
        player:GossipComplete()
    elseif intid == 1 then

        if bossfightInProgress ~= nil then
            player:SendBroadcastMessage("There is already a fight in progress.")
            player:GossipComplete()
            return
        end

        if player:IsInGroup() == false then
            player:SendBroadcastMessage("You need to be in a party.")
            player:GossipComplete()
            return
        end

        if group:IsRaidGroup() == true then
            player:SendBroadcastMessage("You can not accept that task while in a raid group.")
            player:GossipComplete()
            return
        end
        if not group:IsLeader(player:GetGUID()) then
            player:SendBroadcastMessage("You are not the leader of your group.")
            player:GossipComplete()
            return
        end
        groupPlayers = group:GetMembers()
        for n, v in pairs(groupPlayers) do
            if eS_has_value(playersForFireworks, v:GetGUID()) then
                object:SendUnitSay("Please, just a little break. I need to breathe, "..player:GetName()..". How about watching the fireworks?", 0 )
                player:GossipComplete()
                return
            end
        end
        --start 5man encounter
        bossfightInProgress = PARTY_IN_PROGRESS
        spawnedCreature[1]= player:SpawnCreature(Config_addEntry[eventInProgress], x, y, z, o)
        spawnedCreature[1]:SetPhaseMask(2)
        spawnedCreature[1]:SetScale(spawnedCreature[1]:GetScale() * eS_getSize(difficulty))

        local maxHealth = Config_addHealthModifierParty[eventInProgress] * spawnedCreature[1]:GetMaxHealth()
        local health = Config_addHealthModifierParty[eventInProgress] * spawnedCreature[1]:GetHealth()
        spawnedCreature[1]:SetMaxHealth(maxHealth)
        spawnedCreature[1]:SetHealth(health)

        encounterStartTime = GetCurrTime()

        for n, v in pairs(groupPlayers) do
            if v:GetDistance(player) ~= nil then
                if v:GetDistance(player) < 80 then
                    v:SetPhaseMask(2)
                    playersInRaid[n] = v:GetGUID()
                    spawnedCreature[1]:SetInCombatWith(v)
                    v:SetInCombatWith(spawnedCreature[1])
                    spawnedCreature[1]:AddThreat(v, 1)
                end
            else
                v:SendBroadcastMessage("You were too far away to join the fight.")
            end
        end

    elseif intid == 2 then

        if bossfightInProgress ~= nil then
            player:SendBroadcastMessage("There is already a fight in progress.")
            player:GossipComplete()
            return
        end

        if player:IsInGroup() == false then
            player:SendBroadcastMessage("You need to be in a party.")
            player:GossipComplete()
            return
        end

        if group:IsRaidGroup() == false then
            player:SendBroadcastMessage("You can not accept that task without being in a raid group.")
            player:GossipComplete()
            return
        end
        if not group:IsLeader(player:GetGUID()) then
            player:SendBroadcastMessage("You are not the leader of your group.")
            player:GossipComplete()
            return
        end
        groupPlayers = group:GetMembers()

        --prevent starting the next raid while fireworks are running
        for n, v in pairs(groupPlayers) do
            if eS_has_value(playersForFireworks, v:GetGUID()) then
                object:SendUnitSay("Please, just a little break. I need to breathe, "..player:GetName()..". How about watching the fireworks?", 0 )
                player:GossipComplete()
                return
            end
        end

        --start raid encounter
        bossfightInProgress = RAID_IN_PROGRESS

        spawnedBoss = player:SpawnCreature(Config_bossEntry[eventInProgress], x, y, z+2, o)
        spawnedBoss:SetPhaseMask(2)
        spawnedBoss:SetScale(spawnedBoss:GetScale() * eS_getSize(difficulty))
        spawnedBossGuid = spawnedBoss:GetGUID()

        if Config_addsAmount[eventInProgress] == nil then Config_addsAmount[eventInProgress] = 1 end

        for c = 1, Config_addsAmount[eventInProgress] do
            local randomX = (math.sin(math.random(1,360)) * 15)
            local randomY = (math.sin(math.random(1,360)) * 15)
            spawnedCreature[c] = player:SpawnCreature(Config_addEntry[eventInProgress], x + randomX, y + randomY, z+2, o)
            spawnedCreature[c]:SetPhaseMask(2)
            spawnedCreature[c]:SetScale(spawnedCreature[c]:GetScale() * eS_getSize(difficulty))
            spawnedCreatureGuid[c] = spawnedCreature[c]:GetGUID()
        end
        encounterStartTime = GetCurrTime()

        for n, v in pairs(groupPlayers) do
            if v:GetDistance(player) ~= nil then
                if v:GetDistance(player) < 80 then
                    v:SetPhaseMask(2)
                    playersInRaid[n] = v:GetGUID()
                    spawnedBoss:SetInCombatWith(v)
                    v:SetInCombatWith(spawnedBoss)
                    spawnedBoss:AddThreat(v, 1)
                    for c = 1, Config_addsAmount[eventInProgress] do
                        spawnedCreature[c]:SetInCombatWith(v)
                        v:SetInCombatWith(spawnedCreature[c])
                        spawnedCreature[c]:AddThreat(v, 1)
                    end
                end
            else
                v:SendBroadcastMessage("You were too far away to join the fight.")
            end
        end

        --apply auras to adds
        if spawnedCreature[1] ~= nil then
            if Config_aura1Add1[1] ~= nil then
                spawnedCreature[1]:AddAura(Config_aura1Add1[1], spawnedCreature[1])
            end
            if Config_aura2Add1[1] ~= nil then
                spawnedCreature[1]:AddAura(Config_aura2Add1[1], spawnedCreature[1])
            end
        end

        if spawnedCreature[2] ~= nil then
            if Config_aura1Add2[2] ~= nil then
                spawnedCreature[2]:AddAura(Config_aura1Add2[2], spawnedCreature[2])
            end
            if Config_aura2Add2[2] ~= nil then
                spawnedCreature[2]:AddAura(Config_aura2Add2[2], spawnedCreature[2])
            end
        end
        if #spawnedCreature > 2 then
            for c = 3, #spawnedCreature do
                if spawnedCreature[c] ~= nil then
                    if Config_aura1Add3[c] ~= nil then
                        spawnedCreature[c]:AddAura(Config_aura1Add3[c], spawnedCreature[c])
                    end
                    if Config_aura2Add3[c] ~= nil then
                        spawnedCreature[c]:AddAura(Config_aura2Add3[c], spawnedCreature[c])
                    end
                end
            end
        end
    end
    player:GossipComplete()
end

local function eS_chromiePartyOnlyGossip(event, player, object, sender, intid, code, menu_id)
    local spawnedBoss
    local spawnedCreature = {}

    if player == nil then return end

    local group = player:GetGroup()
    local accountId = player:GetAccountId()

    if intid == 0 then
        if scoreEarned[accountId] == nil then scoreEarned[accountId] = 0 end
        if scoreTotal[accountId] == nil then scoreTotal[accountId] = 0 end
        player:SendBroadcastMessage("Your current event score is: "..scoreEarned[accountId].." and your all-time event score is: "..scoreTotal[accountId])
        player:GossipComplete()

    elseif intid <= 100 then
        partyEvent[accountId] = intid

        player:GossipMenuAddItem(OPTION_ICON_CHAT, "Zombie Captain (Level 50)", Config.partySelectNpc, 101)
        player:GossipMenuAddItem(OPTION_ICON_CHAT, "Seawitch (Level 40)", Config.partySelectNpc, 102)
        player:GossipMenuAddItem(OPTION_ICON_CHAT, "Aligator Pet (Level 50)", Config.partySelectNpc, 104)
        player:GossipMenuAddItem(OPTION_ICON_CHAT, "Aligator Guard (Level 60)", Config.partySelectNpc, 105)
        player:GossipMenuAddItem(OPTION_ICON_CHAT, "Ragnarix Qt (Level 60)", Config.partySelectNpc, 106)
        player:GossipSendMenu(Config.defaultNpcText2, object, 0)

    else
        difficulty = partyEvent[accountId]
        partyEvent[accountId] = intid - 100
        if bossfightInProgress ~= nil then
            player:SendBroadcastMessage("There is already a fight in progress.")
            player:GossipComplete()
            return
        end

        if player:IsInGroup() == false then
            player:SendBroadcastMessage("You need to be in a party.")
            player:GossipComplete()
            return
        end

        if group:IsRaidGroup() == true then
            player:SendBroadcastMessage("You can not accept that task while in a raid group.")
            player:GossipComplete()
            return
        end
        if not group:IsLeader(player:GetGUID()) then
            player:SendBroadcastMessage("You are not the leader of your group.")
            player:GossipComplete()
            return
        end
        groupPlayers = group:GetMembers()
        for n, v in pairs(groupPlayers) do
            if eS_has_value(playersForFireworks, v:GetGUID()) then
                object:SendUnitSay("Please, just a little break. I need to breathe, "..player:GetName()..". How about watching the fireworks?", 0 )
                player:GossipComplete()
                return
            end
        end
        eventInProgress = partyEvent[accountId]
        local x = player:GetX()
        local y = player:GetY()
        local z = player:GetZ()
        local o = player:GetO()

        --start 5man encounter
        bossfightInProgress = PARTY_IN_PROGRESS
        spawnedCreature[1]= player:SpawnCreature(Config_addEntry[eventInProgress], x, y, z, o)
        spawnedCreature[1]:SetPhaseMask(2)
        spawnedCreature[1]:SetScale(spawnedCreature[1]:GetScale() * eS_getSize(difficulty))

        local maxHealth = Config_addHealthModifierParty[eventInProgress] * spawnedCreature[1]:GetMaxHealth()
        local health = Config_addHealthModifierParty[eventInProgress] * spawnedCreature[1]:GetHealth()
        spawnedCreature[1]:SetMaxHealth(maxHealth)
        spawnedCreature[1]:SetHealth(health)

        encounterStartTime = GetCurrTime()

        for n, v in pairs(groupPlayers) do
            if v:GetDistance(player) ~= nil then
                if v:GetDistance(player) < 80 then
                    v:SetPhaseMask(2)
                    playersInRaid[n] = v:GetGUID()
                    spawnedCreature[1]:SetInCombatWith(v)
                    v:SetInCombatWith(spawnedCreature[1])
                    spawnedCreature[1]:AddThreat(v, 1)
                end
            else
                v:SendBroadcastMessage("You were too far away to join the fight.")
            end
        end

    end
end

local function eS_summonEventNPC(playerGuid)
    local player
    -- tempSummon an NPC with a dialogue option to start the encounter, store the guid for later unsummon
    player = GetPlayerByGUID(playerGuid)
    if player == nil then return end
    x = player:GetX()
    y = player:GetY()
    z = player:GetZ()
    o = player:GetO()
    local spawnedNPC = player:SpawnCreature(Config_npcEntry[eventInProgress], x, y, z, o)
    spawnedNPCGuid = spawnedNPC:GetGUID()

    -- add an event to spawn the Boss in a phase when gossip is clicked
    cancelEventIdHello[eventInProgress] = RegisterCreatureGossipEvent(Config_npcEntry[eventInProgress], GOSSIP_EVENT_ON_HELLO, eS_onHello)
    cancelEventIdStart[eventInProgress] = RegisterCreatureGossipEvent(Config_npcEntry[eventInProgress], GOSSIP_EVENT_ON_SELECT, eS_chromieGossip)
end

local function eS_command(event, player, command, chatHandler)
    local commandArray = {}
    local eventNPC

    --prevent players from using this
    if not chatHandler:IsAvailable(Config.GMRankForEventStart) then
        return
    end

    -- split the command variable into several strings which can be compared individually
    commandArray = eS_splitString(command)

    if commandArray[2] ~= nil then
        commandArray[2] = commandArray[2]:gsub("[';\\, ]", "")
        if commandArray[3] ~= nil then
            commandArray[3] = commandArray[3]:gsub("[';\\, ]", "")
        end
    end

    if commandArray[2] == nil then commandArray[2] = 1 end
    if commandArray[3] == nil then commandArray[3] = 1 end

    if commandArray[1] == "startevent" then
        if player == nil then
            chatHandler:SendSysMessage("Can not start an event from the console.")
            return false
        end
        eventNPC = tonumber(commandArray[2])
        difficulty = tonumber(commandArray[3])

        if Config_npcEntry[eventNPC] == nil or Config_bossEntry == nil or Config_addEntry == nil or Config_npcText == nil then
            chatHandler:SendSysMessage("Event "..eventNPC.." is not properly configured. Aborting")
            return false
        end

        mapEventStart = player:GetMap():GetMapId()

        if difficulty <= 0 then difficulty = 1 end
        if difficulty > 10 then difficulty = 10 end

        if eventInProgress == nil then
            eventInProgress = eventNPC
            eS_summonEventNPC(player:GetGUID())
            chatHandler:SendSysMessage("Starting event "..eventInProgress.." with difficulty "..difficulty..".")
            return false
        else
            chatHandler:SendSysMessage("Event "..eventInProgress.." is already active.")
            return false
        end
    elseif commandArray[1] == "stopevent" then
        if player == nil then
            chatHandler:SendSysMessage("Must be used from inside the game.")
            return false
        end
        if eventInProgress == nil then
            chatHandler:SendSysMessage("There is no event in progress.")
            return false
        end
        local map = player:GetMap()
        local mapId = map:GetMapId()
        if mapId ~= mapEventStart then
            chatHandler:SendSysMessage("You must be in the same map to stop an event.")
            return false
        end
        chatHandler:SendSysMessage("Stopping event "..eventInProgress..".")
        ClearCreatureGossipEvents(Config_npcEntry[eventInProgress])
        local spawnedNPC = map:GetWorldObject(spawnedNPCGuid):ToCreature()
        spawnedNPC:DespawnOrUnsummon(0)
        eventInProgress = nil
        return false
    end

    --prevent non-Admins from using the rest
    if not chatHandler:IsAvailable(Config.GMRankForUpdateDB) then
        return
    end

    --nothing here yet
    return
end

function bossNPC.onEnterCombat(event, creature, target)
    creature:RegisterEvent(bossNPC.Event, 100, 0)
    creature:CallAssistance()
    creature:SendUnitYell("You will NOT interrupt this mission!", 0 )
    phase = 1
    addsDownCounter = 0
    creature:CallForHelp(200)
    creature:PlayDirectSound(8645)

    lastBossSpell1 = encounterStartTime
    lastBossSpell2 = encounterStartTime
    lastBossSpell3 = encounterStartTime
    lastBossSpell5 = encounterStartTime
    lastBossSpell7 = encounterStartTime
    nextBossSpell8Delay = nil
    lastBossSpellSelf = encounterStartTime
end

function bossNPC.reset(event, creature)
    local player
    eS_checkInCombat()
    creature:RemoveEvents()
    if creature:IsDead() == true then
        creature:SendUnitYell("Master, save me!", 0 )
        creature:PlayDirectSound(8865)
        local playerListString
        for _, v in pairs(playersInRaid) do
            player = GetPlayerByGUID(v)
            if player ~= nil then
                if player:GetCorpse() ~= nil then
                    player:GetCorpse():SetPhaseMask(1)
                end
                player:SetPhaseMask(1)
                if playerListString == nil then
                    playerListString = player:GetName()
                else
                    playerListString = playerListString..", "..player:GetName()
                end
            end
        end
        if Config.rewardRaid == 1 then
            awardScore()
        elseif Config.storeRaid == 1 then
            storeEncounter()
        else
            bossfightInProgress = nil
        end
        SendWorldMessage("The raid encounter "..creature:GetName().." was completed on difficulty "..difficulty.." in "..eS_getEncounterDuration().." by: "..playerListString..". Congratulations!")
        CreateLuaEvent(eS_castFireworks, 1000, 20)
        playersForFireworks = playersInRaid
        playersInRaid = {}
    else
        creature:SendUnitYell("You never had a chance.", 0 )
        for _, v in pairs(playersInRaid) do
            player = GetPlayerByGUID(v)
            if player ~= nil then
                if player:GetCorpse() ~= nil then
                    player:GetCorpse():SetPhaseMask(1)
                end
                player:SetPhaseMask(1)
            end
        end
        playersInRaid = {}
        bossfightInProgress = nil
    end
    creature:DespawnOrUnsummon(0)
    addsDownCounter = nil
end

function bossNPC.Event(event, delay, pCall, creature)
    if creature:IsCasting() == true then return end

    if Config_bossSpellEnrageTimer[eventInProgress] ~= nil and Config_bossSpellEnrage[eventInProgress] ~= nil then
        if eS_getDifficultyTimer(Config_bossSpellEnrageTimer[eventInProgress]) < eS_getTimeSince(encounterStartTime) then
            if phase == 2 and eS_getTimeSince(encounterStartTime) > Config_bossSpellEnrageTimer[eventInProgress] then
                phase = 3
                creature:SendUnitYell("FEEL MY WRATH!", 0 )
                creature:CastSpell(creature, Config_bossSpellEnrage[eventInProgress])
                return
            end
        end
    end

    if Config_bossSpellTimer3[eventInProgress] ~= nil then
        if eS_getDifficultyTimer(Config_bossSpellTimer3[eventInProgress]) < eS_getTimeSince(lastBossSpell3) then
            if addsDownCounter < Config_addsAmount[eventInProgress] then
                if Config_bossSpellSelf[eventInProgress] ~= nil then
                    if Config_bossSpellSelfYell[eventInProgress] ~= nil then
                        creature:SendUnitYell(Config_bossSpellSelfYell[eventInProgress], 0 )
                    end
                    creature:CastSpell(creature, Config_bossSpellSelf[eventInProgress])
                    lastBossSpell3 = GetCurrTime()
                    return
                end
            elseif phase == 1 then
                if Config_bossYellPhase2[eventInProgress] ~= nil then
                    creature:SendUnitYell(Config_bossYellPhase2[eventInProgress], 0 )
                end
                phase = 2
            end
        end
    end

    if Config_bossSpellTimer1[eventInProgress] ~= nil then
        if eS_getDifficultyTimer(Config_bossSpellTimer1[eventInProgress]) < eS_getTimeSince(lastBossSpell1) then
            if Config_bossSpell1[eventInProgress] ~= nil then
                if Config_bossSpellModifier1bp0[eventInProgress] ~= nil and Config_bossSpellModifier1bp1[eventInProgress] ~= nil then
                    local base1 = eS_getDifficultyModifier(Config_bossSpellModifier1bp0[eventInProgress])
                    local base2 = eS_getDifficultyModifier(Config_bossSpellModifier1bp1[eventInProgress])
                    creature:CastCustomSpell(creature:GetVictim(), Config_bossSpell1[eventInProgress], false, base1, base2)
                elseif Config_bossSpellModifier1bp0[eventInProgress] ~= nil then
                    local base1 = eS_getDifficultyModifier(Config_bossSpellModifier1bp0[eventInProgress])
                    creature:CastCustomSpell(creature:GetVictim(), Config_bossSpell1[eventInProgress], false, base1)
                elseif Config_bossSpellModifier1bp1[eventInProgress] ~= nil then
                    local base2 = eS_getDifficultyModifier(Config_bossSpellModifier1bp1[eventInProgress])
                    creature:CastCustomSpell(creature:GetVictim(), Config_bossSpell1[eventInProgress], false, nil, base2)
                else
                    creature:CastSpell(creature:GetVictim(), Config_bossSpell1[eventInProgress])
                end
                lastBossSpell1 = GetCurrTime()
                return
            end
        end
    end

    if Config_bossSpellTimer2[eventInProgress] ~= nil then
        if eS_getDifficultyTimer(Config_bossSpellTimer2[eventInProgress]) < eS_getTimeSince(lastBossSpell2) then
            if Config_bossSpell2[eventInProgress] ~= nil then
                if (math.random(1, 100) <= 50) then
                    if Config_bossSpell2MaxRange[eventInProgress] == nil then
                        Config_bossSpell2MaxRange[eventInProgress] = 35
                    end
                    local players = creature:GetPlayersInRange(Config_bossSpell2MaxRange[eventInProgress])
                    local targetPlayer = players[math.random(1, #players)]
                    creature:SendUnitYell("You die now, "..targetPlayer:GetName().."!", 0 )
                    if Config_bossSpellModifier2bp0[eventInProgress] ~= nil and Config_bossSpellModifier2bp1[eventInProgress] ~= nil then
                        local base1 = eS_getDifficultyModifier(Config_bossSpellModifier2bp0[eventInProgress])
                        local base2 = eS_getDifficultyModifier(Config_bossSpellModifier2bp1[eventInProgress])
                        creature:CastCustomSpell(targetPlayer, Config_bossSpell2[eventInProgress], false, base1, base2)
                    elseif Config_bossSpellModifier2bp0[eventInProgress] ~= nil then
                        local base1 = eS_getDifficultyModifier(Config_bossSpellModifier2bp0[eventInProgress])
                        creature:CastCustomSpell(targetPlayer, Config_bossSpell2[eventInProgress], false, base1)
                    elseif Config_bossSpellModifier2bp1[eventInProgress] ~= nil then
                        local base2 = eS_getDifficultyModifier(Config_bossSpellModifier2bp1[eventInProgress])
                        creature:CastCustomSpell(targetPlayer, Config_bossSpell2[eventInProgress], false, nil, base2)
                    else
                        creature:CastSpell(targetPlayer, Config_bossSpell2[eventInProgress])
                    end
                    lastBossSpell2 = GetCurrTime()
                    return
                end
            end
        end
    end

    if Config_bossSpellTimer3[eventInProgress] ~= nil then
        if eS_getDifficultyTimer(Config_bossSpellTimer3[eventInProgress]) < eS_getTimeSince(lastBossSpell3) then
            if phase > 1 then
                local players = creature:GetPlayersInRange(30)
                if #players > 1 then
                    if (math.random(1, 100) <= 50) then
                        if Config_bossSpell3[eventInProgress] ~= nil then
                            if Config_bossSpellModifier3bp0[eventInProgress] ~= nil and Config_bossSpellModifier3bp1[eventInProgress] ~= nil then
                                local base1 = eS_getDifficultyModifier(Config_bossSpellModifier3bp0[eventInProgress])
                                local base2 = eS_getDifficultyModifier(Config_bossSpellModifier3bp1[eventInProgress])
                                creature:CastCustomSpell(creature:GetAITarget(SELECT_TARGET_NEAREST, true, 1, 30), Config_bossSpell3[eventInProgress], false, base1, base2)
                            elseif Config_bossSpellModifier3bp0[eventInProgress] ~= nil then
                                local base1 = eS_getDifficultyModifier(Config_bossSpellModifier3bp0[eventInProgress])
                                creature:CastCustomSpell(creature:GetAITarget(SELECT_TARGET_NEAREST, true, 1, 30), Config_bossSpell3[eventInProgress], false, base1)
                            elseif Config_bossSpellModifier3bp1[eventInProgress] ~= nil then
                                local base2 = eS_getDifficultyModifier(Config_bossSpellModifier3bp1[eventInProgress])
                                creature:CastCustomSpell(creature:GetAITarget(SELECT_TARGET_NEAREST, true, 1, 30), Config_bossSpell3[eventInProgress], false, nil, base2)
                            else
                                creature:CastSpell(creature:GetAITarget(SELECT_TARGET_NEAREST, true, 1, 30), Config_bossSpell3[eventInProgress])
                            end
                            lastBossSpell3 = GetCurrTime()
                            return
                        end
                    elseif phase > 1 then
                        if Config_bossSpell4[eventInProgress] ~= nil then
                            if Config_bossSpell4MaxRange[eventInProgress] == nil then
                                Config_bossSpell4MaxRange[eventInProgress] = 40
                            end
                            local players = creature:GetPlayersInRange(Config_bossSpell4MaxRange[eventInProgress])
                            local nextPlayerIndex = math.random(1, #players)
                            if Config_bossSpell4Counter[eventInProgress] == nil then
                                Config_bossSpell4Counter[eventInProgress] = 1
                            end
                            for m = 1, Config_bossSpell4Counter[eventInProgress] do
                                local targetPlayer = players[nextPlayerIndex]
                                if targetPlayer then
                                    if Config_bossSpellModifier4bp0[eventInProgress] ~= nil and Config_bossSpellModifier4bp1[eventInProgress] ~= nil then
                                        local base1 = eS_getDifficultyModifier(Config_bossSpellModifier4bp0[eventInProgress])
                                        local base2 = eS_getDifficultyModifier(Config_bossSpellModifier4bp1[eventInProgress])
                                        creature:CastCustomSpell(targetPlayer, Config_bossSpell4[eventInProgress], false, base1, base2)
                                    elseif Config_bossSpellModifier4bp0[eventInProgress] ~= nil then
                                        local base1 = eS_getDifficultyModifier(Config_bossSpellModifier4bp0[eventInProgress])
                                        creature:CastCustomSpell(targetPlayer, Config_bossSpell4[eventInProgress], false, base1)
                                    elseif Config_bossSpellModifier4bp1[eventInProgress] ~= nil then
                                        local base2 = eS_getDifficultyModifier(Config_bossSpellModifier4bp1[eventInProgress])
                                        creature:CastCustomSpell(targetPlayer, Config_bossSpell4[eventInProgress], false, nil, base2)
                                    else
                                        creature:CastSpell(targetPlayer, Config_bossSpell4[eventInProgress])
                                    end
                                    if nextPlayerIndex >= #players then
                                        nextPlayerIndex = 1
                                    else
                                        nextPlayerIndex = nextPlayerIndex + 1
                                    end
                                end
                            end
                            lastBossSpell3 = GetCurrTime()
                            return
                        end
                    end
                else
                    if Config_bossSpell3[eventInProgress] ~= nil then
                        if Config_bossSpellModifier3bp0[eventInProgress] ~= nil and Config_bossSpellModifier3bp1[eventInProgress] ~= nil then
                            local base1 = eS_getDifficultyModifier(Config_bossSpellModifier3bp0[eventInProgress])
                            local base2 = eS_getDifficultyModifier(Config_bossSpellModifier3bp1[eventInProgress])
                            creature:CastCustomSpell(creature:GetVictim(), Config_bossSpell3[eventInProgress], false, base1, base2)
                        elseif Config_bossSpellModifier3bp0[eventInProgress] ~= nil then
                            local base1 = eS_getDifficultyModifier(Config_bossSpellModifier3bp0[eventInProgress])
                            creature:CastCustomSpell(creature:GetVictim(), Config_bossSpell3[eventInProgress], false, base1)
                        elseif Config_bossSpellModifier3bp1[eventInProgress] ~= nil then
                            local base2 = eS_getDifficultyModifier(Config_bossSpellModifier3bp1[eventInProgress])
                            creature:CastCustomSpell(creature:GetVictim(), Config_bossSpell3[eventInProgress], false, nil, base2)
                        else
                            creature:CastSpell(creature:GetVictim(), Config_bossSpell3[eventInProgress])
                        end
                        lastBossSpell3 = GetCurrTime()
                        return
                    end
                end
            end
        end
    end

    if Config_bossSpellTimer5[eventInProgress] ~= nil then
        if eS_getDifficultyTimer(Config_bossSpellTimer5[eventInProgress]) < eS_getTimeSince(lastBossSpell5) then
            if phase == 1 then
                if Config_bossSpell5[eventInProgress] ~= nil then
                    if Config_bossSpellModifier5bp0[eventInProgress] ~= nil and Config_bossSpellModifier5bp1[eventInProgress] ~= nil then
                        local base1 = eS_getDifficultyModifier(Config_bossSpellModifier5bp0[eventInProgress])
                        local base2 = eS_getDifficultyModifier(Config_bossSpellModifier5bp1[eventInProgress])
                        creature:CastCustomSpell(creature:GetVictim(), Config_bossSpell5[eventInProgress], false, base1, base2)
                    elseif Config_bossSpellModifier5bp0[eventInProgress] ~= nil then
                        local base1 = eS_getDifficultyModifier(Config_bossSpellModifier5bp0[eventInProgress])
                        creature:CastCustomSpell(creature:GetVictim(), Config_bossSpell5[eventInProgress], false, base1)
                    elseif Config_bossSpellModifier5bp1[eventInProgress] ~= nil then
                        local base2 = eS_getDifficultyModifier(Config_bossSpellModifier5bp1[eventInProgress])
                        creature:CastCustomSpell(creature:GetVictim(), Config_bossSpell5[eventInProgress], false, nil, base2)
                    else
                        creature:CastSpell(creature:GetVictim(), Config_bossSpell5[eventInProgress])
                    end
                    lastBossSpell5 = GetCurrTime()
                    return
                end
            else
                if Config_bossSpell6[eventInProgress] ~= nil then
                    if Config_bossSpellModifier6bp0[eventInProgress] ~= nil and Config_bossSpellModifier6bp1[eventInProgress] ~= nil then
                        local base1 = eS_getDifficultyModifier(Config_bossSpellModifier6bp0[eventInProgress])
                        local base2 = eS_getDifficultyModifier(Config_bossSpellModifier6bp1[eventInProgress])
                        creature:CastCustomSpell(creature:GetVictim(), Config_bossSpell6[eventInProgress], false, base1, base2)
                    elseif Config_bossSpellModifier6bp0[eventInProgress] ~= nil then
                        local base1 = eS_getDifficultyModifier(Config_bossSpellModifier6bp0[eventInProgress])
                        creature:CastCustomSpell(creature:GetVictim(), Config_bossSpell6[eventInProgress], false, base1)
                    elseif Config_bossSpellModifier6bp1[eventInProgress] ~= nil then
                        local base2 = eS_getDifficultyModifier(Config_bossSpellModifier6bp1[eventInProgress])
                        creature:CastCustomSpell(creature:GetVictim(), Config_bossSpell6[eventInProgress], false, nil, base2)
                    else
                        creature:CastSpell(creature:GetVictim(), Config_bossSpell6[eventInProgress])
                    end
                    lastBossSpell5 = GetCurrTime()
                    return
                end
            end
        end
    end

    if Config_minPhaseForTimer7[eventInProgress] == nil then
        Config_minPhaseForTimer7[eventInProgress] = 1
    end
    if Config_bossSpellTimer7[eventInProgress] ~= nil and phase >= Config_minPhaseForTimer7[eventInProgress] then
        if nextBossSpell8Delay ~= nil then
            if Config_bossSpell8[eventInProgress] ~= nil then
                if Config_bossSpell8delay[eventInProgress] < eS_getTimeSince(nextBossSpell8Delay) then
                    if Config_bossSpellModifier8bp0[eventInProgress] ~= nil and Config_bossSpellModifier8bp1[eventInProgress] ~= nil then
                        local base1 = eS_getDifficultyModifier(Config_bossSpellModifier8bp0[eventInProgress])
                        local base2 = eS_getDifficultyModifier(Config_bossSpellModifier8bp1[eventInProgress])
                        creature:CastCustomSpell(creature:GetVictim(), Config_bossSpell8[eventInProgress], false, base1, base2)
                    elseif Config_bossSpellModifier8bp0[eventInProgress] ~= nil then
                        local base1 = eS_getDifficultyModifier(Config_bossSpellModifier8bp0[eventInProgress])
                        creature:CastCustomSpell(creature:GetVictim(), Config_bossSpell8[eventInProgress], false, base1)
                    elseif Config_bossSpellModifier8bp1[eventInProgress] ~= nil then
                        local base2 = eS_getDifficultyModifier(Config_bossSpellModifier8bp1[eventInProgress])
                        creature:CastCustomSpell(creature:GetVictim(), Config_bossSpell8[eventInProgress], false, nil, base2)
                    else
                        creature:CastSpell(creature:GetVictim(), Config_bossSpell8[eventInProgress])
                    end
                    nextBossSpell8Delay = nil
                    return
                end
            end
        end

        if eS_getDifficultyTimer(Config_bossSpellTimer7[eventInProgress]) < eS_getTimeSince(lastBossSpell7) then
            if Config_bossSpell7[eventInProgress] ~= nil then
                if Config_bossSpellModifier7bp0[eventInProgress] ~= nil and Config_bossSpellModifier7bp1[eventInProgress] ~= nil then
                    local base1 = eS_getDifficultyModifier(Config_bossSpellModifier7bp0[eventInProgress])
                    local base2 = eS_getDifficultyModifier(Config_bossSpellModifier7bp1[eventInProgress])
                    creature:CastCustomSpell(creature:GetVictim(), Config_bossSpell7[eventInProgress], false, base1, base2)
                elseif Config_bossSpellModifier7bp0[eventInProgress] ~= nil then
                    local base1 = eS_getDifficultyModifier(Config_bossSpellModifier7bp0[eventInProgress])
                    creature:CastCustomSpell(creature:GetVictim(), Config_bossSpell7[eventInProgress], false, base1)
                elseif Config_bossSpellModifier7bp1[eventInProgress] ~= nil then
                    local base2 = eS_getDifficultyModifier(Config_bossSpellModifier7bp1[eventInProgress])
                    creature:CastCustomSpell(creature:GetVictim(), Config_bossSpell7[eventInProgress], false, nil, base2)
                else
                    creature:CastSpell(creature:GetVictim(), Config_bossSpell7[eventInProgress])
                end
                lastBossSpell7 = GetCurrTime()
                nextBossSpell8Delay = lastBossSpell7
                return
            end
        end
    end
end

function addNPC.onEnterCombat(event, creature, target)
    local player


    creature:RegisterEvent(addNPC.Event, math.random(100,150), 0)

    creature:CallAssistance()
    creature:CallForHelp(200)
    for _, v in pairs(playersInRaid) do
        player = GetPlayerByGUID(v)
        if player ~= nil then
            creature:AddThreat(player, 1)
        end
    end
    addphase = 1

    if bossfightInProgress == PARTY_IN_PROGRESS then
        lastAddSpell1[1] = encounterStartTime
        lastAddSpell2[1] = encounterStartTime
        lastAddSpell3[1] = encounterStartTime
        lastAddSpell4[1] = encounterStartTime
    else
        for n, _ in pairs(spawnedCreatureGuid) do
            lastAddSpell1[n] = encounterStartTime
            lastAddSpell2[n] = encounterStartTime
            lastAddSpell3[n] = encounterStartTime
            lastAddSpell4[n] = encounterStartTime
        end
    end
end

function addNPC.Event(event, delay, pCall, creature)
    if creature:IsCasting() == true then return end

    if bossfightInProgress == PARTY_IN_PROGRESS and Config_addSpell1[eventInProgress] ~= nil then  -- only for the party version
        if addphase == 1 and creature:GetHealthPct() < 67 then
            addphase = 2
        elseif addphase == 2 and creature:GetHealthPct() < 34 then
            addphase = 3
        end
        if addphase == 1 and creature:GetHealthPct() < 67 or addphase == 2 and creature:GetHealthPct() < 34 then
            if Config_addEnoughYell[eventInProgress] ~= nil then
                creature:SendUnitYell(Config_addEnoughYell[eventInProgress], 0 )
            end
            if Config_addEnoughSound[eventInProgress] ~= nil then
                creature:PlayDirectSound(Config_addEnoughSound[eventInProgress])
            end
            local players = creature:GetPlayersInRange(30)
            if #players > 1 then
                creature:CastSpell(creature:GetAITarget(SELECT_TARGET_FARTHEST, true, 0, 30), Config.addEnoughSpell)
                return
            else
                creature:CastSpell(creature:GetAITarget(SELECT_TARGET_FARTHEST, true, 0, 30), Config_addSpell1[eventInProgress])
                return
            end
        end
    end

    local n = eS_returnIndex(spawnedCreatureGuid, creature:GetGUID())   -- tell multiple adds apart in raid mode
    if n == false then n = 1 end                                        -- no need to set this in party mode


    if Config_addSpellEnrage[eventInProgress] ~= nil then
        if eS_getDifficultyTimer(Config.addEnrageTimer) < eS_getTimeSince(encounterStartTime)then
            if phase == 2 and eS_getTimeSince(encounterStartTime) > Config_addSpellEnrage[eventInProgress] then
                phase = 3
                creature:SendUnitYell("FEEL MY WRATH!", 0 )
                creature:CastSpell(creature, Config_addSpellEnrage[eventInProgress])
                return
            end
        end
    end

    local randomTimer = math.random(0,1000)

    if Config_addSpellTimer1[eventInProgress] ~= nil and Config_addSpell1[eventInProgress] ~= nil then
        if eS_getDifficultyTimer(Config_addSpellTimer1[eventInProgress]) < randomTimer + eS_getTimeSince(lastAddSpell1[n]) then
            local random = math.random(0, 2)
            local players = creature:GetPlayersInRange(30)
            if #players > 1 then
                if Config_addSpellModifier1bp0[eventInProgress] ~= nil and Config_addSpellModifier1bp1[eventInProgress] ~= nil then
                    local base1 = eS_getDifficultyModifier(Config_addSpellModifier1bp0[eventInProgress])
                    local base2 = eS_getDifficultyModifier(Config_addSpellModifier1bp1[eventInProgress])
                    creature:CastCustomSpell(creature:GetAITarget(SELECT_TARGET_FARTHEST, true, random, 30), Config_addSpell1[eventInProgress], false, base1, base2)
                elseif Config_addSpellModifier1bp0[eventInProgress] ~= nil then
                    local base1 = eS_getDifficultyModifier(Config_addSpellModifier1bp0[eventInProgress])
                    creature:CastCustomSpell(creature:GetAITarget(SELECT_TARGET_FARTHEST, true, random, 30), Config_addSpell1[eventInProgress], false, base1)
                elseif Config_addSpellModifier1bp1[eventInProgress] ~= nil then
                    local base2 = eS_getDifficultyModifier(Config_addSpellModifier1bp1[eventInProgress])
                    creature:CastCustomSpell(creature:GetAITarget(SELECT_TARGET_FARTHEST, true, random, 30), Config_addSpell1[eventInProgress], false, nil, base2)
                else
                    creature:CastSpell(creature:GetAITarget(SELECT_TARGET_FARTHEST, true, random, 30), Config_addSpell1[eventInProgress])
                end
                lastAddSpell1[n] = GetCurrTime()
                return
            else
                if Config_addSpellModifier1bp0[eventInProgress] ~= nil and Config_addSpellModifier1bp1[eventInProgress] ~= nil then
                    local base1 = eS_getDifficultyModifier(Config_addSpellModifier1bp0[eventInProgress])
                    local base2 = eS_getDifficultyModifier(Config_addSpellModifier1bp1[eventInProgress])
                    creature:CastCustomSpell(creature:GetVictim(), Config_addSpell1[eventInProgress], false, base1, base2)
                elseif Config_addSpellModifier1bp0[eventInProgress] ~= nil then
                    local base1 = eS_getDifficultyModifier(Config_addSpellModifier1bp0[eventInProgress])
                    creature:CastCustomSpell(creature:GetVictim(), Config_addSpell1[eventInProgress], false, base1)
                elseif Config_addSpellModifier1bp1[eventInProgress] ~= nil then
                    local base2 = eS_getDifficultyModifier(Config_addSpellModifier1bp1[eventInProgress])
                    creature:CastCustomSpell(creature:GetVictim(), Config_addSpell1[eventInProgress], false, nil, base2)
                else
                    creature:CastSpell(creature:GetVictim(),Config_addSpell1[eventInProgress])
                end
                lastAddSpell1[n] = GetCurrTime()
                return
            end
        end
    end

    if Config_addSpellTimer2[eventInProgress] ~= nil and Config_addSpell2[eventInProgress] ~= nil then
        if eS_getDifficultyTimer(Config_addSpellTimer2[eventInProgress]) < randomTimer + (eS_getTimeSince(lastAddSpell2[n])) then
            if Config_addSpell2Sound[eventInProgress] ~= nil then
                creature:PlayDirectSound(Config_addSpell2Sound[eventInProgress])
            end
            if Config_addSpellModifier2bp0[eventInProgress] ~= nil and Config_addSpellModifier2bp1[eventInProgress] ~= nil then
                local base1 = eS_getDifficultyModifier(Config_addSpellModifier2bp0[eventInProgress])
                local base2 = eS_getDifficultyModifier(Config_addSpellModifier2bp1[eventInProgress])
                creature:CastCustomSpell(creature:GetVictim(), Config_addSpell2[eventInProgress], false, base1, base2)
            elseif Config_addSpellModifier2bp0[eventInProgress] ~= nil then
                local base1 = eS_getDifficultyModifier(Config_addSpellModifier2bp0[eventInProgress])
                creature:CastCustomSpell(creature:GetVictim(), Config_addSpell2[eventInProgress], false, base1)
            elseif Config_addSpellModifier2bp1[eventInProgress] ~= nil then
                local base2 = eS_getDifficultyModifier(Config_addSpellModifier2bp1[eventInProgress])
                creature:CastCustomSpell(creature:GetVictim(), Config_addSpell2[eventInProgress], false, nil, base2)
            else
                creature:CastSpell(creature:GetVictim(), Config_addSpell2[eventInProgress])
            end
            lastAddSpell2[n] = GetCurrTime()
            return
        end
    end

    if Config_addSpellTimer3[eventInProgress] ~= nil and Config_addSpell3[eventInProgress] ~= nil then
        if eS_getDifficultyTimer(Config_addSpellTimer3[eventInProgress]) < randomTimer + eS_getTimeSince(lastAddSpell3[n]) then
            if Config_addSpell3Yell[eventInProgress] ~= nil then
                creature:SendUnitYell(Config_addSpell3Yell[eventInProgress], 0 )
            end
            if Config_addSpellModifier3bp0[eventInProgress] ~= nil and Config_addSpellModifier3bp1[eventInProgress] ~= nil then
                local base1 = eS_getDifficultyModifier(Config_addSpellModifier3bp0[eventInProgress])
                local base2 = eS_getDifficultyModifier(Config_addSpellModifier3bp1[eventInProgress])
                creature:CastCustomSpell(creature, Config_addSpell3[eventInProgress], false, base1, base2)
            elseif Config_addSpellModifier3bp0[eventInProgress] ~= nil then
                local base1 = eS_getDifficultyModifier(Config_addSpellModifier3bp0[eventInProgress])
                creature:CastCustomSpell(creature, Config_addSpell3[eventInProgress], false, base1)
            elseif Config_addSpellModifier3bp1[eventInProgress] ~= nil then
                local base2 = eS_getDifficultyModifier(Config_addSpellModifier3bp1[eventInProgress])
                creature:CastCustomSpell(creature, Config_addSpell3[eventInProgress], false, nil, base2)
            else
                creature:CastSpell(creature, Config_addSpell3[eventInProgress])
            end
            lastAddSpell3[n] = GetCurrTime()
            return
        end
    end

    if bossfightInProgress == RAID_IN_PROGRESS then
        if Config_addSpellTimer4[eventInProgress] ~= nil and Config_addSpell4[eventInProgress] ~= nil then
            if eS_getDifficultyTimer(Config_addSpellTimer4[eventInProgress]) < randomTimer + eS_getTimeSince(lastAddSpell4[n]) then
                local map = creature:GetMap()
                if map ~= nil then
                    if  map:GetWorldObject(spawnedBossGuid) ~= nil then
                        local bossNPC = map:GetWorldObject(spawnedBossGuid):ToCreature()
                        creature:CastSpell(bossNPC, Config_addSpell4[eventInProgress])
                        lastAddSpell4[n] = GetCurrTime()
                        return
                    end
                end
            end
        end
    end
end

function addNPC.reset(event, creature)
    local player
    if bossfightInProgress == PARTY_IN_PROGRESS then
        eS_checkInCombat()
    end
    creature:RemoveEvents()
    if bossfightInProgress == PARTY_IN_PROGRESS then
        if creature:IsDead() == true then
            local playerListString
            CreateLuaEvent(eS_castFireworks, 1000, 20)
            creature:PlayDirectSound(8803)
            for _, v in pairs(playersInRaid) do
                player = GetPlayerByGUID(v)
                if player ~= nil then
                    if player:GetCorpse() ~= nil then
                        player:GetCorpse():SetPhaseMask(1)
                    end
                    player:SetPhaseMask(1)
                    if playerListString == nil then
                        playerListString = player:GetName()
                    else
                        playerListString = playerListString..", "..player:GetName()
                    end
                end
            end
            if Config.rewardParty == 1 then
                awardScore()
            elseif Config.storeParty == 1 then
                storeEncounter()
            else
                bossfightInProgress = nil
            end
            SendWorldMessage("The party encounter "..creature:GetName().." was completed on difficulty "..difficulty.." in "..eS_getEncounterDuration().." by: "..playerListString..". Congratulations!")
            playersForFireworks = playersInRaid
            playersInRaid = {}
        else
            creature:SendUnitYell("Hahahaha!", 0 )
            for _, v in pairs(playersInRaid) do
                player = GetPlayerByGUID(v)
                if player ~= nil then
                    if player:GetCorpse() ~= nil then
                        player:GetCorpse():SetPhaseMask(1)
                    end
                    player:SetPhaseMask(1)
                end
            end
            playersInRaid = {}
            bossfightInProgress = nil
        end
    else
        if creature:IsDead() == true then
            if addsDownCounter == nil then
                addsDownCounter = 1
            else
                addsDownCounter = addsDownCounter + 1
            end
        end
    end
    creature:DespawnOrUnsummon(0)
end

local function initBossEvents()
    for n = Config_bossEntry[1], Config_bossEntry[1] + 990, 10 do
        if eS_has_value(Config_bossEntry,n) then
            RegisterCreatureEvent(n, 1, bossNPC.onEnterCombat)
            RegisterCreatureEvent(n, 2, bossNPC.reset) -- OnLeaveCombat
            RegisterCreatureEvent(n, 4, bossNPC.reset) -- OnDied
        else
            return
        end
    end
end

local function initAddEvents()
    for n = Config_addEntry[1], Config_addEntry[1] + 990, 10 do
        if eS_has_value(Config_addEntry,n) then
            RegisterCreatureEvent(n, 1, addNPC.onEnterCombat)
            RegisterCreatureEvent(n, 2, addNPC.reset) -- OnLeaveCombat
            RegisterCreatureEvent(n, 4, addNPC.reset) -- OnDied
        else
            return
        end
    end
end

local function eS_partyNpcYell(eventid, delay, repeats, worldobject)
    if partyNpcSayCounter == 10 then
        worldobject:SendUnitYell(Config.PartyNpcYellText, 0)
        partyNpcSayCounter = 0
    else
        worldobject:SendUnitSay(Config.PartyNpcSayText, 0)
        partyNpcSayCounter = partyNpcSayCounter + 1
    end
end

local function eS_CloseLua(eI_CloseLua)
    if npcObjectGuid ~= nil then
        local npcObject
        local map
        map = GetMapById(Config.MapId)
        if not map then
            return
        end
        npcObject = map:GetWorldObject(npcObjectGuid):ToCreature()
        if not npcObject then
            return
        end
        npcObject:DespawnOrUnsummon(0)
    end
end

--on ReloadEluna / Startup
RegisterPlayerEvent(PLAYER_EVENT_ON_COMMAND, eS_command)
RegisterPlayerEvent(PLAYER_EVENT_ON_REPOP, eS_resetPlayers)

initBossEvents()
initAddEvents()

CharDBQuery('CREATE DATABASE IF NOT EXISTS `'..Config.customDbName..'`;');
CharDBQuery('CREATE TABLE IF NOT EXISTS `'..Config.customDbName..'`.`eventscript_encounters` (`time_stamp` INT NOT NULL, `playerGuid` INT NOT NULL, `encounter` INT DEFAULT 0, `difficulty` TINYINT DEFAULT 0, `group_type` TINYINT DEFAULT 0, `duration` INT NOT NULL, PRIMARY KEY (`time_stamp`, `playerGuid`));');
CharDBQuery('CREATE TABLE IF NOT EXISTS `'..Config.customDbName..'`.`eventscript_score` (`account_id` INT NOT NULL, `score_earned_current` INT DEFAULT 0, `score_earned_total` INT DEFAULT 0, PRIMARY KEY (`account_id`));')

local Data_SQL = CharDBQuery('SELECT * FROM `'..Config.customDbName..'`.`eventscript_score`;')
if Data_SQL ~= nil then
    local account
    repeat
        account = Data_SQL:GetUInt32(0)
        scoreEarned[account] = Data_SQL:GetUInt32(1)
        scoreTotal[account] = Data_SQL:GetUInt32(2)
    until not Data_SQL:NextRow()
end

if Config.partySelectNpcActive == 1 then
    RegisterServerEvent(ELUNA_EVENT_ON_LUA_STATE_CLOSE, eS_CloseLua, 0)
    RegisterCreatureGossipEvent(Config.partySelectNpc, GOSSIP_EVENT_ON_HELLO, eS_onPartyOnlyHello)
    RegisterCreatureGossipEvent(Config.partySelectNpc, GOSSIP_EVENT_ON_SELECT, eS_chromiePartyOnlyGossip)
    local npcObject = PerformIngameSpawn(1, Config.partySelectNpc, Config.MapId, Config.InstanceId, Config.NpcX, Config.NpcY, Config.NpcZ, Config.NpcO)
    npcObjectGuid = npcObject:GetGUID()
    npcObject:RegisterEvent(eS_partyNpcYell, 60000, 0)
end
