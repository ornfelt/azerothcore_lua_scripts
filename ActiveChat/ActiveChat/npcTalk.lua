local enableScript = true  -- Set to true to enable the script, false to disable

if enableScript then

local talk_time = {1000,10000} -- Chat spam time interval: 1 second = 1000
local guild_talk_time= {10000,30000} -- Guild chat spam time interval: 1 second = 1000
local ns = ""  
-- Select data from the database as the source of npc names. If left blank, use the name set in npc_name.lua.

local t = {}

-- List of zones
local zones = {
    "Elwynn Forest", "Westfall", "Redridge Mountains", "Duskwood", "Loch Modan",
    "Wetlands", "Dun Morogh", "Searing Gorge", "Burning Steppes", "The Hinterlands",
    "Silverpine Forest", "Tirisfal Glades", "Western Plaguelands", "Eastern Plaguelands",
    "Hillsbrad Foothills", "Arathi Highlands", "Stranglethorn Vale", "Badlands",
    "Swamp of Sorrows", "The Blasted Lands", "Alterac Mountains", "Deadwind Pass",
    "Kalimdor", "Durotar", "Mulgore", "The Barrens", "Stonetalon Mountains",
    "Ashenvale", "Thousand Needles", "Desolace", "Dustwallow Marsh", "Feralas",
    "Tanaris", "Azshara", "Felwood", "Un'Goro Crater", "Moonglade", "Silithus",
    "Winterspring", "Darkshore", "Teldrassil", "Bloodmyst Isle", "Azuremyst Isle",
    "Ghostlands", "Eversong Woods", "Isle of Quel'Danas", "Hellfire Peninsula",
    "Zangarmarsh", "Terokkar Forest", "Nagrand", "Blade's Edge Mountains", "Netherstorm",
    "Shadowmoon Valley", "Borean Tundra", "Howling Fjord", "Dragonblight",
    "Grizzly Hills", "Zul'Drak", "Sholazar Basin", "The Storm Peaks", "Icecrown",
    "Crystalsong Forest", "Wintergrasp"
}

local instances = {
    -- Vanilla
    "RFC", -- Ragefire Chasm
    "WC", -- Wailing Caverns
    "VC", -- The Deadmines (commonly referred to as "Van Cleef" or "VC")
    "SFK", -- Shadowfang Keep
    "BFD", -- Blackfathom Deeps
    "Stocks", -- The Stockade
    "Gnomer", -- Gnomeregan
    "RFK", -- Razorfen Kraul
    "SM", -- Scarlet Monastery
    "RFD", -- Razorfen Downs
    "Ulda", -- Uldaman
    "ZF", -- Zul'Farrak
    "Mara", -- Maraudon
    "ST", -- Temple of Atal'Hakkar (Sunken Temple)
    "BRD", -- Blackrock Depths
    "LBRS", -- Lower Blackrock Spire
    "UBRS", -- Upper Blackrock Spire
    "DM", -- Dire Maul
    "Strat", -- Stratholme
    "Scholo", -- Scholomance
    "MC", -- Molten Core
    "Ony", -- Onyxia's Lair
    "BWL", -- Blackwing Lair
    "ZG", -- Zul'Gurub
    "AQ20", -- Ruins of Ahn'Qiraj
    "AQ40", -- Temple of Ahn'Qiraj
	"Naxx40", -- Naxx 40
	"Ony40", -- Onyxia 40

    -- The Burning Crusade
    "Ramps", -- Hellfire Ramparts
    "BF", -- The Blood Furnace
    "SP", -- The Slave Pens
    "UB", -- The Underbog
    "MT", -- Mana-Tombs
    "AC", -- Auchenai Crypts
    "Sethekk", -- Sethekk Halls
    "SLabs", -- Shadow Labyrinth
    "SV", -- The Steamvault
    "SH", -- The Shattered Halls
    "Bot", -- The Botanica
    "Mech", -- The Mechanar
    "Arc", -- The Arcatraz
    "MgT", -- Magisters' Terrace
    "Kara", -- Karazhan
    "Gruul's", -- Gruul's Lair
    "Maggi", -- Magtheridon's Lair
    "SSC", -- Serpentshrine Cavern
    "TK", -- The Eye
    "Hyjal", -- Battle for Mount Hyjal
    "BT", -- Black Temple
    "SWP", -- Sunwell Plateau

    -- Wrath of the Lich King
    "UK", -- Utgarde Keep
    "Nexus", -- The Nexus
    "AN", -- Azjol-Nerub
    "AK", -- Ahn'kahet: The Old Kingdom
    "DTK", -- Drak'Tharon Keep
    "VH", -- The Violet Hold
    "Gun", -- Gundrak
    "HoS", -- Halls of Stone
    "HoL", -- Halls of Lightning
    "Ocu", -- The Oculus
    "UP", -- Utgarde Pinnacle
    "ToC", -- Trial of the Champion
    "FoS", -- The Forge of Souls
    "PoS", -- Pit of Saron
    "HoR", -- Halls of Reflection
    "Naxx", -- Naxxramas
    "OS", -- The Obsidian Sanctum
    "EoE", -- The Eye of Eternity
    "Uldu", -- Ulduar
    "ToGC", -- Trial of the Crusader
    "Ony", -- Onyxia's Lair (Revamped)
    "ICC", -- Icecrown Citadel
    "RS", -- The Ruby Sanctum
	
	 -- Vanilla
    "Ragefire Chasm", "Wailing Caverns", "The Deadmines", "Shadowfang Keep", "Blackfathom Deeps",
    "The Stockade", "Gnomeregan", "Razorfen Kraul", "Scarlet Monastery", "Razorfen Downs",
    "Uldaman", "Zul'Farrak", "Maraudon", "Temple of Atal'Hakkar", "Blackrock Depths",
    "Lower Blackrock Spire", "Upper Blackrock Spire", "Dire Maul", "Stratholme", "Scholomance",
    "Molten Core", "Onyxia's Lair", "Blackwing Lair", "Zul'Gurub", "Ruins of Ahn'Qiraj",
    "Temple of Ahn'Qiraj",

    -- The Burning Crusade
    "Hellfire Ramparts", "The Blood Furnace", "The Slave Pens", "The Underbog", "Mana-Tombs",
    "Auchenai Crypts", "Sethekk Halls", "Shadow Labyrinth", "The Steamvault", "The Shattered Halls",
    "The Botanica", "The Mechanar", "The Arcatraz", "Magisters' Terrace", "Karazhan",
    "Gruul's Lair", "Magtheridon's Lair", "Serpentshrine Cavern", "The Eye", "Battle for Mount Hyjal",
    "Black Temple", "Sunwell Plateau",

    -- Wrath of the Lich King
    "Utgarde Keep", "The Nexus", "Azjol-Nerub", "Ahn'kahet: The Old Kingdom", "Drak'Tharon Keep",
    "The Violet Hold", "Gundrak", "Halls of Stone", "Halls of Lightning", "The Oculus",
    "Utgarde Pinnacle", "Trial of the Champion", "The Forge of Souls", "Pit of Saron", "Halls of Reflection",
    "Naxxramas", "The Obsidian Sanctum", "The Eye of Eternity", "Ulduar", "Trial of the Crusader",
    "Onyxia's Lair", "Icecrown Citadel", "The Ruby Sanctum"
}


local roles = {"Tank", "Healer", "DPS"}

local classes = {    "Warrior", "Mage", "Rogue", "Priest", "Hunter", 
    "Paladin", "Shaman", "Warlock", "Druid", "Death Knight"
}

local battlegrounds = {"WG", "AV", "WSG", "AB", "Strand", "Isle of Conquest", "EoS"
}

-- Function to randomly select a zone
local function selectRandomZone()
    return zones[math.random(#zones)]
end

local function selectRandomInstance()
    return instances[math.random(#instances)]
end

local function selectRandomRole()
    return roles[math.random(#roles)]
end

local function selectRandomClass()
    return classes[math.random(#classes)]
end

local function selectRandomBattleground()
    return battlegrounds[math.random(#battlegrounds)]
end

t.t = {
    talk = require("npc_text"),
    guild_talk = require("npc_text_guild"),
}

t.cc = {"C79C6E","F58CBA","ABD473","FFF569","FFFFFF","C41F3B","0070DE","69CCF0","9482C9","FF7d0A" }

t.init = function(s)
    math.randomseed(tostring(os.time()):reverse():sub(1, 7))
    s.d = require("npc_name") or {}
    if (ns ~= "") then
        local q = WorldDBQuery(ns)
        if (q) then
            repeat
                table.insert(s.d, q:GetString(0))
            until not q:NextRow()
        end
    end
end
t:init()

t.fg = function(s, talkType)
    math.randomseed(tostring(os.time()):reverse():sub(1, 7))
    local i = math.random(#s.t[talkType])
    s.t[talkType][0][1] = i
    s.t[talkType][0][2] = 1
    if (type(s.t[talkType][i]) == "string") then
        return s.t[talkType][i]
    elseif (type(s.t[talkType][i]) == "table") then
        s.t[talkType][0][2] = s.t[talkType][0][2] + 1
        return s.t[talkType][i][1]
    end
end

-- Modified function to generate current chat text
t.dt = function(s, talkType)
    local i = s.t[talkType][0][1]
    local ti = s.t[talkType][0][2]
    local t = ""
    if (type(s.t[talkType][i]) == "string") then
        t = s:fg(talkType)
    end
    if (type(s.t[talkType][i]) == "table") then
        if (#s.t[talkType][i] < ti) then
            t = s:fg(talkType)
        else
            t = s.t[talkType][i][ti]
            s.t[talkType][0][2] = s.t[talkType][0][2] + 1
        end
    end

    -- Replace placeholders with randomly selected items
    t = string.gsub(t, "%%zone%%", selectRandomZone())
    t = string.gsub(t, "%%instance%%", selectRandomInstance())
    t = string.gsub(t, "%%role%%", selectRandomRole())
    t = string.gsub(t, "%%class%%", selectRandomClass())
    t = string.gsub(t, "%%bg%%", selectRandomBattleground())

    return t
end

-- Create a public chat event
CreateLuaEvent(function()
    local n = t.d[math.random(#t.d)]
    SendWorldMessage(string.format("|cFFFFC0C0[World]|r|cff%s|Hplayer:%s|h[%s]|h|r:|cFFFFC0C0%s|r", t.cc[math.random(#t.cc)], n, n, t:dt("talk")))
end, {talk_time[1], talk_time[2]}, 0)

-- Create a guild chat event
CreateLuaEvent(function()
    local n = t.d[math.random(#t.d)]
    SendWorldMessage(string.format("|cFF40FF40[Guild]|Hplayer:%s|h[%s]|h:%s|r", n, n, t:dt("guild_talk")))
end, {guild_talk_time[1], guild_talk_time[2]}, 0)

-- Process secret words and invitation packets
--RegisterServerEvent(5, function(_, p, w)
--    local c = p:GetOpcode()
--    if (c == 0x095) then
--        local t = p:ReadULong()
--       local l = p:ReadULong()
--        local n = p:ReadString()
--        local m = p:ReadString()
--        if (t == 7 and n ~= w:GetName()) then
--            SendWorldMessage(string.format("|cFFFF80FF|Hplayer:%s|h[%s]|h whispered quietly:%s|r", n, n, m))
--        end
--    end

--    if (c == 0x06E) then
--        local n = p:ReadString()
--        SendWorldMessage(string.format("%s declined your invitation.", n))
--    end

--    if (c == 0x069) then
--        local n = p:ReadString()
--        SendWorldMessage(string.format("%s declined your invitation.", n))
--    end
--end)
end
