--------------------------- ARENA SPECTATOR -----------------------------
-- Author: Kerhong                                                     --
-- Description: Allows better arena spectator experience               --
-- Dependencies: Server side required (closed source)                  --
-- Modifications: pussywizard                                          --
-- Credit to Binny the Love Fool for TidyPlates                        --
-------------------------------------------------------------------------

local TimeFrame = CreateFrame("frame", nil, WorldFrame)
TimeFrame.text = TimeFrame:CreateFontString("OVERLAY")
TimeFrame.text:SetPoint("TOP", WorldFrame, "TOP", 0, -85)
TimeFrame.text:SetFont(STANDARD_TEXT_FONT, 20, "OUTLINE")
TimeFrame.text:SetText("00:00")
TimeFrame:Hide()

-- Slash commands
SLASH_TEAMNAME_ONE1 = '/teamname1'
SLASH_TEAMNAME_TWO1 = '/teamname2'
SLASH_UPDATE_SCORE1 = '/score'
SLASH_RESET_SCORE1 = '/resetscore'
SLASH_TOURNAMENT1 = '/tournament'
SLASH_TEAMSWITCH1 = '/teamswitch'
SLASH_TEAMSWITCH2 = '/switchteams'
SLASH_DEBUG1 = '/asdebug'

local dtable = {
    [0]="none", 
    [1]="magic",
    [2]="curse",
    [3]="disease",
    [4]="poison" 
}

-- Texts
local TEXT = {
    ["TOGGLEUI"] = "Toggle UI",
    ["SUCCESS"] = "SUCCESS",
    ["INTERRUPTED"] = "INTERRUPTED"
}

local DTC = { 
    ["none"] = { r = 0.80, g = 0, b = 0 },
    ["magic"] = { r = 0.20, g = 0.60, b = 1.00 },
    ["curse"] = { r = 0.60, g = 0.00, b = 1.00 },
    ["disease"] = { r = 0.60, g = 0.40, b = 0 },
    ["poison"] = { r = 0.00, g = 0.60, b = 0 },
}


local BAR_TEXTURE = "Interface\\Addons\\SunwellAS\\media\\BarTexture2"

-- Colors (format: { Red, Green, Blue, Alpha }), values from 0.0 to 1.0
local COLOR = {
    ["BACKGROUND"] = {0.0, 0.0, 0.0, 1.0},
    ["HEALTH"] = {0.1, 0.8, 0.2, 1.0},
    ["HEALTH_BG"] = {0.0, 0.16, 0.0, 0.4},
    ["CASTBAR"] = {0.70, 0.70, 0.40, 1.0},
    ["CASTBAR_BG"] = {0.16, 0.17, 0.19, 1.0},
    ["CASTBAR_TEXT"] = {1.0, 1.0, 1.0, 1.0},
    ["CASTBAR_SUCCESS"] = {0.3, 0.8, 0.3, 0.8},
    ["CASTBAR_SUCCESS_TEXT"] = {1.0, 1.0, 1.0, 1.0},
    ["CASTBAR_INTERRUPT"] = {0.8, 0.3, 0.3, 0.8},
    ["CASTBAR_INTERRUPT_TEXT"] = {1.0, 1.0, 1.0, 1.0},
    ["MANA"] = {0.27, 0.17, 0.98, 1.0},
    ["MANA_BG"] = {0.0, 0.0, 0.2, 0.9},
    ["RAGE"] = {0.81, 0.01, 0.10, 1.0},
    ["RAGE_BG"] = {0.2, 0, 0, 0.9},
    ["ENERGY"] = {0.80, 0.80, 0.0, 1.0},
    ["ENERGY_BG"] = {0.2, 0.2, 0.0, 0.9},
    ["RUNICPOWER"] = {0.0, 0.7, 9.0, 1.0},
    ["RUNICPOWER_BG"] = {0.0, 0.16, 0.2, 0.9},
}

local CLASS_COLORS = {
    ["WARRIOR"] = {.78, .61, .43, 1},
    ["WARLOCK"] = {.58, .51, .79, 1},
    ["SHAMAN"] = {0, .44, .87, 1},
    ["ROGUE"] = {1, .96, .41, 1},
    ["PRIEST"] = {1, 1, 1, 1},
    ["PALADIN"] = {1, .65, .8, 1},
    ["MAGE"] = {.41, .8, .94, 1},
    ["HUNTER"] = {.67, .83, .45, 1},
    ["DRUID"] = {1, .6, .04, 1},
    ["DEATHKNIGHT"] = {.77, .12, .23, 1}
}

-- Frame sizes
local SIZE = {
    ["SMALL"] = { -- Small (team) frame
        ["HEIGHT"] = 40, -- Frame height
        ["WIDTH"] = 230, -- Frame width
        ["NAMETEXTSIZE"] = 16, -- Player name font size
        ["HEALTHHEIGHT"] = 25, -- Healthbar height
        ["HEALTHTEXTSIZE"] = 16, -- Health text size
        ["POWERTEXTSIZE"] = 10, -- Power bar text size
        ["CASTBARHEIGHT"] = 15, -- Castbar height
        ["CASTBARTEXTSIZE"] = 12, -- Castbar text size
        ["TRINKETSIZE"] = 25, -- Trinket display size
        ["TRINKETOFFSET"] = 5, -- Trinket from corner of class icon
        ["FRAMEPOSITION"] = -200, -- 1st team frame initial position, relative to center Y of screen
        ["FRAMEPOSITION4V4"] = -350, -- 1st team frame initial position, relative to center Y of screen
        ["FRAMEINCREMENT"] = 150, -- Increment of FRAMEPOSITION for each next frame
        ["FRAMEFROMBORDER"] = 10, -- Frame spacing from edge of screen
        ["SPELLSIZE"] = 32 -- Spell display size
    },
    
    ["BIG"] = { -- Big frames (current POV, POV's target)
        ["HEIGHT"] = 60, -- Frame height
        ["WIDTH"] = 300, -- Frame width
        ["NAMETEXTSIZE"] = 16, -- Player name font size
        ["HEALTHHEIGHT"] = 40, -- Healthbar height
        ["HEALTHTEXTSIZE"] = 25, -- Health text size
        ["POWERTEXTSIZE"] = 10, -- Power bar text size
        ["CASTBARPOSITIONY"] = -76, -- Position Y for castbars of bottom frames
        ["CASTBARHEIGHT"] = 20, -- Castbar height
        ["CASTBARTEXTSIZE"] = 14, -- Castbar text size
        ["FRAMEPOSITION"] = 3, -- Frame offset from centerX on screen
        ["FRAMEFROMBORDER"] = 30, -- Frame spacing from bottom of screen
        ["SPELLSIZE"] = 50 -- Spell display size
    },
    
    ["PET"] = { -- Pet frames (current POV, POV's target)
        ["HEIGHT"] = 36, -- Frame height
        ["WIDTH"] = 36, -- Frame width
        ["NAMETEXTSIZE"] = 12, -- Player name font size
        ["POSITIONY"] = 0, -- Frame offset from centerY on screen
        ["FRAMEFROMBORDER"] = 242, -- Frame spacing from bottom of screen
    }
}

local PLAYERPETS = {
    [0]  = "inv_misc_questionmark",
    [1]  = "Ability_Hunter_Pet_Wolf",
    [2]  = "Ability_Hunter_Pet_Cat",
    [3]  = "Ability_Hunter_Pet_Spider",
    [4]  = "Ability_Hunter_Pet_Bear",
    [5]  = "Ability_Hunter_Pet_Boar",
    [6]  = "Ability_Hunter_Pet_Crocolisk",
    [7]  = "Ability_Hunter_Pet_Vulture",
    [8]  = "Ability_Hunter_Pet_Crab",
    [9]  = "Ability_Hunter_Pet_Gorilla",
    [11] = "Ability_Hunter_Pet_Raptor",
    [12] = "Ability_Hunter_Pet_TallStrider",
    [15] = "spell_shadow_summonfelhunter",  -- Not hunter pet
    [16] = "spell_shadow_summonvoidwalker", -- Not hunter pet
    [17] = "spell_shadow_summonsuccubus",   -- Not hunter pet
    [19] = "spell_shadow_summonimp",        -- Not hunter pet *correct?*
    [20] = "Ability_Hunter_Pet_Scorpid",
    [21] = "Ability_Hunter_Pet_Turtle",
    [23] = "spell_shadow_summonimp",        -- Not hunter pet
    [24] = "Ability_Hunter_Pet_Bat",
    [25] = "Ability_Hunter_Pet_Hyena",
    [26] = "Ability_Hunter_Pet_Owl",
    [27] = "Ability_Hunter_Pet_WindSerpent",
    [28] = "inv_misc_questionmark",         -- Not hunter pet (WTF IS THIS? - Remote Control)
    [29] = "spell_shadow_summonfelguard",   -- Not hunter pet
    [30] = "Ability_Hunter_Pet_DragonHawk",
    [31] = "Ability_Hunter_Pet_Ravager",
    [32] = "Ability_Hunter_Pet_WarpStalker",
    [33] = "Ability_Hunter_Pet_Sporebat",
    [34] = "Ability_Hunter_Pet_NetherRay",
    [35] = "Spell_Nature_GuardianWard",
    [37] = "Ability_Hunter_Pet_Moth",
    [38] = "Ability_Hunter_Pet_Chimera",
    [39] = "Ability_Hunter_Pet_Devilsaur",
    [40] = "spell_shadow_animatedead",      -- Not hunter pet *correct?*
    [41] = "Ability_Hunter_Pet_Silithid",
    [42] = "Ability_Hunter_Pet_Worm",
    [43] = "Ability_Hunter_Pet_Rhino",
    [44] = "Ability_Hunter_Pet_Wasp",
    [45] = "Ability_Hunter_Pet_CoreHound",
    [46] = "Ability_Druid_PrimalPrecision"
}

--------------------------------------------------
--                                              --
--       DO NOT MODIFY BELOW THIS POINT         --
--                                              --
--------------------------------------------------

function GetTableSize(table)
    if (table ~= nil) then
        local i = 0
        for _ in pairs(table) do
            i = i + 1
        end
        
        return i
    end
    
    return 0
end

math.round = function(number, precision)
    precision = precision or 0

    local decimal = string.find(tostring(number), ".", nil, true);
    
    if ( decimal ) then    
        local power = 10 ^ precision;
        
        if ( number >= 0 ) then 
            number = math.floor(number * power + 0.5) / power;
        else 
            number = math.ceil(number * power - 0.5) / power;        
        end
        
        -- convert number to string for formatting
        number = tostring(number);            
        
        -- set cutoff
        local cutoff = number:sub(decimal + 1 + precision);
            
        -- delete everything after the cutoff
        number = number:gsub(cutoff, "");
    else
        -- number is an integer
        if ( precision > 0 ) then
            number = tostring(number);
            
            number = number .. ".";
            
            for i = 1,precision
            do
                number = number .. "0";
            end
        end
    end        
    return number;
end

-- Player Classes Global for Colored Nameplates
classes = {}

-- Saved variables
teamname = {[0]="Use /teamname1 to set name", [1]="Use /teamname2 to set name"}
teamscore = {[0]=0, [1]=0}
tournamentMode = false
specingEnabled = false
debugMode = false

-- Each class icon coordinates in Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes
local _CLASS_ICON_TCOORDS = {
 ["WARRIOR"] = {0, 0.25, 0, 0.25},
 ["MAGE"] = {0.25, 0.49609375, 0, 0.25},
 ["ROGUE"] = {0.49609375, 0.7421875, 0, 0.25},
 ["DRUID"] = {0.7421875, 0.98828125, 0, 0.25},
 ["HUNTER"] = {0, 0.25, 0.25, 0.5},
 ["SHAMAN"] = {0.25, 0.49609375, 0.25, 0.5},
 ["PRIEST"] = {0.49609375, 0.7421875, 0.25, 0.5},
 ["WARLOCK"] = {0.7421875, 0.98828125, 0.25, 0.5},
 ["PALADIN"] = {0, 0.25, 0.5, 0.75},
 ["DEATHKNIGHT"] = {0.25, 0.49609375, 0.5, 0.75},
}

-- Table with all player data
ATPlayers = {}

-- Toggle UI button
local toggle

-- Scoreboard Frame
local scoreFrame
local teamOneScoreBox
local teamOneNameBox
local teamTwoScoreBox
local teamTwoNameBox

-- Current watched target
watch = nil

-- All bar names that share same properties (for easier updates)
local ALLBARS = { "fsmall", "fself", "ftarget" }
local globalCastbar = 0

-- Holds bool that makes default UI visible/hidden
local hideui

-- Time in seconds for ability to fade fully
local SPELLDISPLAYTIME = 5

-- Aura levels (aura with highest level gets shown on portret frame)
local ROOT = 1
local STUN = 4
local SILENCE = 2 -- also disarm
local CROWDC = 3
local IMMUNITY = 5

-- List of PVP trinket spells and cooldowns
local pvptrinket
if (select(4, GetBuildInfo()) < 30000) then
-- TBC IDs
    pvptrinket = {
        [42292] = 120,
    }

else
-- WOTLK IDs
    pvptrinket = {
        [65547] = 120,
        [42292] = 120,
        [59752] = 120,
        [7744] = 45
    }
end

-- List of all CC auras
local auralist
if (select(4, GetBuildInfo()) < 30000) then
-- TBC AURAS
    auralist = {
-- Crowd control
        [33786]     = STUN,     -- Cyclone
        [2637]  = CROWDC,   -- Hibernate
        [18657]     = CROWDC,   -- Hibernate
        [18658]     = CROWDC,   -- Hibernate
        [14309]     = CROWDC,   -- Freezing Trap Effect
        [6770]  = CROWDC,   -- Sap
        [2094]  = CROWDC,   -- Blind
        [5782]  = CROWDC,   -- Fear
        [27223] = CROWDC,   -- Death Coil Warlock
        [6358]  = CROWDC,   -- Seduction (Succubus)
        [5484]  = CROWDC,   -- Howl of Terror
        [17928]     = CROWDC,   -- Howl of Terror
        [5246]  = CROWDC,   -- Intimidating Shout
        [8122]  = CROWDC,   -- Psychic Scream
        [8124]  = CROWDC,   -- Psychic Scream
        [10888]     = CROWDC,   -- Psychic Scream
        [10890]     = CROWDC,   -- Psychic Scream
        [12826]     = CROWDC,   -- Polymorph
        [28272]     = CROWDC,   -- Polymorph pig
        [28271]     = CROWDC,   -- Polymorph turtle
        [710]   = CROWDC,   -- Banish
        [18647] = CROWDC,   -- Banish

        -- Roots
        [339]   = ROOT,     -- Entangling Roots
        [9853]  = ROOT,     -- Entangling Roots
        [27088] = ROOT, -- Frost Nova
        [45334]     = ROOT,     -- Feral Charge effect

        -- Stuns and incapacitates
        [8983]  = STUN,     -- Bash
        [1833]  = STUN, -- Cheap Shot
        [8643]  = STUN,     -- Kidney Shot
        [1776]  = CROWDC,   -- Gouge
        [19503]     = CROWDC,   -- Scatter Shot
        [10308] = STUN,     -- Hammer of Justice
        [20066]     = CROWDC,   -- Repentance

        -- Silences
        [18469]     = SILENCE,  -- Improved Counterspell
        [15487]     = SILENCE,  -- Silence
        [34490]     = SILENCE,  -- Silencing Shot
        [18425] = SILENCE,  -- Improved Kick
        [19647]     = SILENCE,  -- Spell Lock (Felhunter)
        [1330]  = SILENCE,          -- Garrote - Silence

        -- Immunities
        [34692]     = IMMUNITY,     -- The Beast Within
        [45438]     = IMMUNITY,     -- Ice Block
        [642]   = IMMUNITY, -- Divine Shield
    }
else
-- WOTLK AURAS
    auralist = {
        -- Death Knight
        [47481] = STUN,             -- Gnaw (Ghoul)
        [51209] = CROWDC,           -- Hungering Cold
        [47476] = SILENCE,          -- Strangulate
        -- Druid
        [8983]  = STUN,             -- Bash (also Shaman Spirit Wolf ability)
        [33786] = STUN,             -- Cyclone
        [18658] = CROWDC,           -- Hibernate (works against Druids in most forms and Shamans using Ghost Wolf)
        [49802] = STUN,             -- Maim
        [49803] = STUN,             -- Pounce
        [53308] = ROOT,             -- Entangling Roots
        [53313] = ROOT,             -- Entangling Roots (Nature's Grasp)
        [45334] = ROOT,             -- Feral Charge Effect (immobilize with interrupt [spell lockout, not silence])
        -- Hunter
        [60210] = CROWDC,           -- Freezing Arrow Effect
        [14309] = CROWDC,           -- Freezing Trap Effect
        [24394] = STUN,             -- Intimidation
        [14327] = CROWDC,           -- Scare Beast (works against Druids in most forms and Shamans using Ghost Wolf)
        [19503] = CROWDC,           -- Scatter Shot
        [49012] = CROWDC,           -- Wyvern Sting
        [34490] = SILENCE,          -- Silencing Shot
        [53359] = SILENCE,          -- Chimera Shot - Scorpid
        [19306] = ROOT,             -- Counterattack
        [64804] = ROOT,             -- Entrapment
        -- Hunter Pets
        [53568] = STUN,             -- Sonic Blast (Bat)
        [53543] = SILENCE,          -- Snatch (Bird of Prey)
        [53548] = ROOT,             -- Pin (Crab)
        [53562] = STUN,             -- Ravage (Ravager)
        [55509] = ROOT,             -- Venom Web Spray (Silithid)
        [4167]  = ROOT,             -- Web (Spider)
        -- Mage
        [44572] = STUN,             -- Deep Freeze
        [31661] = CROWDC,           -- Dragon's Breath
        [12355] = CROWDC,           -- Impact
        [12826] = CROWDC,           -- Polymorph
        [55021] = SILENCE,          -- Silenced - Improved Counterspell
        [64346] = SILENCE,          -- Fiery Payback
        [33395] = ROOT,             -- Freeze (Water Elemental)
        [42917] = ROOT,             -- Frost Nova
        [12494] = ROOT,             -- Frostbite
        [55080] = ROOT,             -- Shattered Barrier
        -- Paladin
        [10308] = STUN,             -- Hammer of Justice
        [48817] = CROWDC,           -- Holy Wrath (works against Warlocks using Metamorphasis and Death Knights using Lichborne)
        [20066] = CROWDC,           -- Repentance
        [20170] = STUN,             -- Stun (Seal of Justice proc)
        [10326] = CROWDC,           -- Turn Evil (works against Warlocks using Metamorphasis and Death Knights using Lichborne)
        [63529] = SILENCE,          -- Shield of the Templar
        -- Priest
        [605]   = CROWDC,           -- Mind Control
        [64044] = STUN,             -- Psychic Horror
        [10890] = CROWDC,           -- Psychic Scream
        [10955] = CROWDC,           -- Shackle Undead (works against Death Knights using Lichborne)
        [15487] = SILENCE,          -- Silence
        [64058] = SILENCE,          -- Psychic Horror (duplicate debuff names not allowed atm, need to figure out how to support this later)
        -- Rogue
        [2094]  = CROWDC,           -- Blind
        [1833]  = STUN,             -- Cheap Shot
        [1776]  = CROWDC,           -- Gouge
        [8643]  = STUN,             -- Kidney Shot
        [51724] = CROWDC,           -- Sap
        [1330]  = SILENCE,          -- Garrote - Silence
        [18425] = SILENCE,          -- Silenced - Improved Kick
        [51722] = SILENCE,          -- Dismantle
        -- Shaman
        [39796] = STUN,             -- Stoneclaw Stun
        [51514] = CROWDC,           -- Hex (although effectively a silence+disarm effect, it is conventionally thought of as a CROWDC, plus you can trinket out of it)
        [64695] = ROOT,             -- Earthgrab (Storm, Earth and Fire)
        [63685] = ROOT,             -- Freeze (Frozen Power)
        -- Warlock
        [18647] = STUN,             -- Banish (works against Warlocks using Metamorphasis and Druids using Tree Form)
        [47860] = STUN,             -- Death Coil
        [6215]  = CROWDC,           -- Fear
        [17928] = CROWDC,           -- Howl of Terror
        [6358]  = CROWDC,           -- Seduction (Succubus)
        [47847] = STUN,             -- Shadowfury
        [24259] = SILENCE,          -- Spell Lock (Felhunter)
        -- Warrior
        [7922]  = STUN,             -- Charge Stun
        [12809] = STUN,             -- Concussion Blow
        [20253] = STUN,             -- Intercept (also Warlock Felguard ability)
        [20511] = CROWDC,           -- Intimidating Shout
        [5246]  = CROWDC,           -- Intimidating Shout
        [12798] = STUN,             -- Revenge Stun
        [46968] = STUN,             -- Shockwave
        [18498] = SILENCE,          -- Silenced - Gag Order
        [676]   = SILENCE,          -- Disarm
        [58373] = ROOT,             -- Glyph of Hamstring
        [23694] = ROOT,             -- Improved Hamstring
        -- Other
        [20549] = STUN,             -- War Stomp
        [28730] = SILENCE,          -- Arcane Torrent
        -- Immunities
        [46924] = IMMUNITY,         -- Bladestorm (Warrior)
        [642]   = IMMUNITY,         -- Divine Shield (Paladin)
        [45438] = IMMUNITY,         -- Ice Block (Mage)
        [34471] = IMMUNITY,         -- The Beast Within (Hunter)
        [12051] = IMMUNITY,         -- Evocation (Mage)
        [47585] = IMMUNITY          -- Dispersion (Priest)
    }
end

local notShownAuras = {
    2479,       -- Honorless Target
    32724,      -- Gold team      
    32725,      -- Green team
    35774,      -- Gold team
    35775       -- Green team
}

-- Takes class ID (id) and gives text for texture positioning
function ClassToTexture(id)
    if (id == 1) then -- warrior
        return "WARRIOR"
    elseif (id == 2) then -- paladin
        return "PALADIN"
    elseif (id == 3) then -- hunter
        return "HUNTER"
    elseif (id == 4) then -- rogue
        return "ROGUE"
    elseif (id == 5) then -- priest
        return "PRIEST"
    elseif (id == 6) then -- dk
        return "DEATHKNIGHT"
    elseif (id == 7) then -- sham
        return "SHAMAN"
    elseif (id == 8) then -- mage
        return "MAGE"
    elseif (id == 9) then -- lock
        return "WARLOCK"
    elseif (id == 11) then -- druid
        return "DRUID"
    else
        return "WARRIOR"
    end
end

local function IsPlayerGUID(guid)
	return tonumber(guid:sub(5,5)) == 0
end

local function GetUnitByName(value)
    for _, p in pairs(ATPlayers) do
        if p.name == value then
            return p
        end
    end
    
    return false
end

local function GetPlayerByName(value)    
    for _, p in pairs(ATPlayers) do
        if p.name == value and IsPlayerGUID(p.guid) then
            return p
        end
    end
    
    return false
end

-- Realigns all small frames
local function RealignFrames()
    local tableSize = GetTableSize(ATPlayers)
    local team0 = tableSize > 6 and SIZE.SMALL.FRAMEPOSITION4V4 or SIZE.SMALL.FRAMEPOSITION
    local team1 = tableSize > 6 and SIZE.SMALL.FRAMEPOSITION4V4 or SIZE.SMALL.FRAMEPOSITION
    local team0cd = 0
    local team1cd = 0
    for _, p in pairs(ATPlayers) do
        local diffy
        local diffypet
        local side
        local opposite
        local sidemod
        local enemy = false
        local cdside
        local cdoffset
        p.fsmall.main:SetBackdrop({
            bgFile = "", 
            edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
            tile = true,
            tileSize = 2,
            edgeSize = 2
        })
        p.fself.main:SetBackdrop({
            bgFile = "", 
            edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
            tile = true,
            tileSize = 2,
            edgeSize = 2
        })
        p.ftarget.main:SetBackdrop({
            bgFile = "", 
            edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
            tile = true,
            tileSize = 2,
            edgeSize = 2
        })
        p.fsmall.pet1:SetBackdrop({
            bgFile = "", 
            edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
            tile = true,
            tileSize = 2,
            edgeSize = 2,
        })
        if (p.team == 67) then
            p.fsmall.main:SetBackdropBorderColor(1.0, 0.0, 0.0, 0.75)
            p.fself.main:SetBackdropBorderColor(1.0, 0.0, 0.0, 0.75)
            p.ftarget.main:SetBackdropBorderColor(1.0, 0.0, 0.0, 0.75)
            p.fsmall.pet1:SetBackdropBorderColor(1.0, 0.0, 0.0, 0.75)
            team0 = team0 + SIZE.SMALL.FRAMEINCREMENT
            diffy = team0
            diffypet = team0 + SIZE.PET.POSITIONY
            
            side = "TOPLEFT"
            opposite = "TOPRIGHT"
            
            cdside = "BOTTOMLEFT"
            cdoffset = team0cd
            team0cd = team0cd + 60
            
            sidemod = 1
            enemy = false
        else
            p.fsmall.main:SetBackdropBorderColor(0.0, 0.5, 1.0, 0.75)
            p.fself.main:SetBackdropBorderColor(0.0, 0.5, 1.0, 0.75)
            p.ftarget.main:SetBackdropBorderColor(0.0, 0.5, 1.0, 0.75)
            p.fsmall.pet1:SetBackdropBorderColor(0.0, 0.5, 1.0, 0.75)
            team1 = team1 + SIZE.SMALL.FRAMEINCREMENT
            diffy = team1
            diffypet = team1 + SIZE.PET.POSITIONY
            
            side = "TOPRIGHT"
            opposite = "TOPLEFT"
            
            cdside = "BOTTOMRIGHT"
            cdoffset = team1cd
            team1cd = team1cd + 60
            
            sidemod = -1
            enemy = true
        end
        p.fsmall.main:ClearAllPoints()
        p.fsmall.main:SetPoint(enemy and "RIGHT" or "LEFT", enemy and -SIZE.SMALL.FRAMEFROMBORDER or SIZE.SMALL.FRAMEFROMBORDER, diffy)
        p.fsmall.class:ClearAllPoints()
        p.fsmall.class:SetPoint(enemy and "TOPRIGHT" or "TOPLEFT", p.fsmall.main, enemy and -2 or 2, -2)
        p.fsmall.class:SetWidth(p.fsmall.main:GetHeight()-4)
        p.fsmall.class:SetHeight(p.fsmall.main:GetHeight()-4)
        p.fsmall.pet:ClearAllPoints()
        p.fsmall.pet:SetPoint(enemy and "RIGHT" or "LEFT", enemy and -SIZE.PET.FRAMEFROMBORDER or SIZE.PET.FRAMEFROMBORDER, diffypet)
        
        p.fsmall.castbg:ClearAllPoints()
        p.fsmall.castbg:SetPoint("TOP", p.fsmall.main, "BOTTOM", 0, -2)
        p.fsmall.castbg:SetPoint(enemy and "LEFT" or "RIGHT", p.fsmall.main, 2, -2)
        
        p.fsmall.health:ClearAllPoints()
        p.fsmall.health:SetPoint(enemy and "TOPRIGHT" or "TOPLEFT", p.fsmall.class, enemy and "TOPLEFT" or "TOPRIGHT", enemy and -2 or 2, 0)
        
        p.fsmall.trinket:ClearAllPoints()
        p.fsmall.trinket:SetPoint("CENTER", p.fsmall.class, side=="TOPLEFT" and "BOTTOMLEFT" or "BOTTOMRIGHT", sidemod * SIZE.SMALL.TRINKETOFFSET, SIZE.SMALL.TRINKETOFFSET)

        p.cooldowns:ClearAllPoints()
        p.cooldowns:SetPoint(cdside, WorldFrame, cdside, 0, cdoffset)
        p.cooldowns.growdir = sidemod
        
        p.fsmall.main.CombatFeedbackText:SetPoint("CENTER", enemy and -84 or 80, 2)
        
        local temp = 0
        if (p.pet > "0") then
            if (sidemod == 1) then
                temp = SIZE.PET.WIDTH + 5
            else
                temp = -SIZE.PET.WIDTH - 5
            end
        end
        
        for i = 0, 3, 1 do
            p.fsmall.spells[i]:ClearAllPoints()
            p.fsmall.spells[i]:SetPoint(side, p.fsmall.main, opposite, temp + sidemod * (2 + (2 + SIZE.SMALL.SPELLSIZE) * i), 0)
        end
    end
end

-- Change's spectators viewpoint to player with frame (frame)
local function SetViewPoint(frame)
    local target = GetPlayerByName(frame.text:GetText())
    if target == false or target.name == "UNNAMED" then
        return
    end
    
    SendChatMessage(".spect watch " .. frame.text:GetText(), "GUILD");

    if (watch ~= nil) then
        ATPlayers[watch].fself.main:Hide()
        if (ATPlayers[watch].target ~= nil) then
            if (ATPlayers[ATPlayers[watch].target] ~= nil) then
                ATPlayers[ATPlayers[watch].target].ftarget.main:Hide()
            end
        end
    end

    watch = target.guid
    if (watch ~= nil) then
        ATPlayers[watch].fself.main:Show()
        if (ATPlayers[watch].target ~= nil) then
            if (ATPlayers[ATPlayers[watch].target] ~= nil) then
                ATPlayers[ATPlayers[watch].target].ftarget.main:Show()
            end
        end
    end
end

-- PlayerFrame update function, called before every UI redraw
local function UpdateFrame(self, elapsed)
    local target = self.guid

    for i = 0, 3, 1 do
        ATPlayers[target].spells[i].tim = ATPlayers[target].spells[i].tim - elapsed
        if (ATPlayers[target].spells[i].tim < 0) then
            ATPlayers[target].spells[i].tim = 0
        end

        local newalpha = ATPlayers[target].spells[i].tim / SPELLDISPLAYTIME
        local newialpha = 0
        if ((ATPlayers[target].spells[i].interrupted == true) and (newalpha ~= 0)) then
            newialpha = 2 * newalpha
            if (newialpha > 1) then
                newialpha = 1
            end
        end

        for _, barname in pairs(ALLBARS) do
            ATPlayers[target][barname].spells[i].texture:SetAlpha(newalpha)
            ATPlayers[target][barname].spells[i].interrupttexture:SetAlpha(newialpha)
        end
    end
end

-- Global castbar update function, updates castbars for all ATPlayers, called before every UI redraw
local function UpdateCastBar(self, elapsed)
    for _, p in pairs(ATPlayers) do
        local goal = select(2, p.fsmall.cast:GetMinMaxValues())
        local current = p.fsmall.cast:GetValue()
        local direction = p.fsmall.cast.direction
        if direction < 0 then
            goal = 0
        end
        local change = elapsed * direction
        
        if (direction > 0 and current < goal) or (direction < 0 and current > goal) then
            if ((p.fsmall.cast.text:GetText() == TEXT.SUCCESS) or (p.fsmall.cast.text:GetText() == TEXT.INTERRUPTED)) then
                for _, barname in pairs(ALLBARS) do
                    p[barname].cast.text2:SetText("")
                end
            else
                for _, barname in pairs(ALLBARS) do
                    if (direction > 0) then
                        p[barname].cast.text2:SetText(math.round(current, 2) .. "/" .. math.round(goal, 2))
                    else
                        p[barname].cast.text2:SetText(math.round(current, 2))
                    end
                end
            end
            for _, barname in pairs(ALLBARS) do
                p[barname].cast:SetValue(current + change)
            end
        else
            if ((p.fsmall.cast.text:GetText() == TEXT.SUCCESS) or (p.fsmall.cast.text:GetText() == TEXT.INTERRUPTED)) then
                for _, barname in pairs(ALLBARS) do
                    p[barname].cast:SetAlpha(0)
                    p[barname].castbg:SetAlpha(0)
                end
            else
                for _, barname in pairs(ALLBARS) do
                    p[barname].cast.texture:SetTexture(unpack(COLOR.CASTBAR_SUCCESS))
                    p[barname].cast:SetStatusBarColor(unpack(COLOR.CASTBAR_SUCCESS))
                    p[barname].cast:GetStatusBarTexture():SetTexture(unpack(COLOR.CASTBAR_SUCCESS))
                    p[barname].cast.text:SetTextColor(unpack(COLOR.CASTBAR_SUCCESS_TEXT))
                    p[barname].cast.text:SetText(TEXT.SUCCESS)
                    p[barname].cast.direction = 1
                    p[barname].cast:SetMinMaxValues(0, 0.7)
                    p[barname].cast:SetValue(0)
                    p[barname].cast.icon:Hide()
                end
            end
        end
    end
end


local SetPosition = function(icons, x)
    if(icons and x > 0) then
        local col = 0
        local row = 0
        local gap = true
        local sizex = (icons.size or 24) + (icons['spacing-x'] or icons.spacing or 0)
        local sizey = (icons.size or 24) + (icons['spacing-y'] or icons.spacing or 0)
        local anchor = icons.initialAnchor or "BOTTOMLEFT"
        local growthx = (icons["growth-x"] == "LEFT" and -1) or 1
        local growthy = (icons["growth-y"] == "DOWN" and -1) or 1
        local cols = math.floor(icons:GetWidth() / sizex + .5)
        local rows = math.floor(icons:GetHeight() / sizey + .5)
        
        for i = 1, #icons do
            local button = icons[i].icon
            if(button and button.on == 1 and button.debuff == 1) then
                if(col >= cols) then
                    col = 0
                    row = row + 1
                end
                button:ClearAllPoints()
                button:SetPoint(anchor, icons, anchor, col * sizex * growthx, row * sizey * growthy)

                col = col + 1
            elseif(not button) then
                break
            end
        end
        
        for i = 1, #icons do
            local button = icons[i].icon
            if(button and button.on == 1 and button.debuff == 0) then
                if (gap and button:GetAlpha()==1) then
                    if(col > 0) then
                        row = row + 1
                        col = 0
                    end

                    gap = false
                end

                if(col >= cols) then
                    col = 0
                    row = row + 1
                end
                button:ClearAllPoints()
                button:SetPoint(anchor, icons, anchor, col * sizex * growthx, row * sizey * growthy)

                col = col + 1
            elseif(not button) then
                break
            end
        end
        
    end
end


local createAuraIcon = function(unit, framename, icons, index)
    local button = CreateFrame("Button", "aura"..framename..unit..index, icons)
    button:SetWidth(icons.size or 24)
    button:SetHeight(icons.size or 24)
    
    local cd = CreateFrame("Cooldown", button:GetName().."Cooldown", button)
    cd:SetAllPoints(button)
    cd:SetReverse()

    local icon = button:CreateTexture(button:GetName().."Icon", "BORDER")
    icon:SetAllPoints(button)
    icon:SetTexCoord(.1,.9,.1,.9)

    local count = button:CreateFontString(button:GetName().."count", "OVERLAY")
    count:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
    count:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 1, 1)

    local overlayframe = CreateFrame("frame", button:GetName().."OverlayFrame", button)
    overlayframe:SetAllPoints(button)
    local overlay = overlayframe:CreateTexture(button:GetName().."Overlay", "OVERLAY")
    overlay:SetTexture("Interface\\AddOns\\SunwellAS\\media\\border")
    overlay:SetPoint("TOPLEFT", -2, 2)
    overlay:SetPoint("BOTTOMRIGHT", 2, -2)
    
    button.overlay = overlay
    button.overlayframe = overlayframe
    button.parent = icons
    button.icon = icon
    button.count = count
    button.cd = cd
    button.debuff = 1

    return button
end

local updateIcon = function(unit, framename, icons, index, spellId, count, expiration, duration, debufftype, isDebuff)
    local name, _, texture = GetSpellInfo(spellId)
    local icon = icons[index].icon or createAuraIcon(unit, framename, icons, index)
    icon.debuff = isDebuff
    
    if texture then
        local cd = icon.cd
        if(cd and not icons.disableCooldown) then
            if (duration and duration > 0) then
                cd.cdStart = GetTime() - (duration - expiration) / 1000
                cd.cdDuration = duration / 1000
            
                cd:SetCooldown(cd.cdStart, cd.cdDuration)
                cd:Show()
            else
                cd:Hide()
            end
        end
        
        if debufftype and isDebuff==0 then
            local color = DTC[dtable[debufftype]] or DTC.none
            icon.overlay:SetVertexColor(color.r, color.g, color.b)
        else
            icon.overlay:SetVertexColor(0,0,0)
        end

        icon.icon:SetTexture(texture)
        icon.count:SetText((count > 1 and count))
        icon:SetScript("OnEnter", function(...)
            if (debugMode) then
                print(name .. " (" .. spellId .. ")")
            end
        end)

        icon:SetID(index)
        
        icon:SetAlpha(1)
        icon.on = 1
    end
    icons[index].icon = icon
end

local ResetAuras = function(aurastack)
    for index=1, #aurastack do
        if aurastack[index].icon then 
            aurastack[index].icon:SetAlpha(0)         
            aurastack[index].icon.on = 0
        end
    end
end

local getFree = function(object)
    for i=1,#object.spells do
        if object.spells[i].busy == false then
            object.spells[i].busy = true
            object.spells[i].timestamp = 0
			object.spells[i].spellid = 0
            return object.spells[i]
        end
    end
    
    local frm = CreateFrame("frame", nil, object)
    frm:SetWidth(object:GetWidth())
    frm:SetHeight(object:GetHeight())
    frm:SetPoint("BOTTOM")
    frm.icon = frm:CreateTexture(nil, "OVERLAY")
    frm.icon:SetAllPoints()
    frm.cooldownFrame = CreateFrame("Cooldown", nil, frm)
    frm.cooldownFrame:SetAllPoints(frm)
    frm.cooldownFrame:SetReverse()
    frm.busy = true
    frm.timestamp = 0
	frm.spellid = 0
    tinsert(object.spells, frm)
    return frm
end

local Resort = function(object)
    local tbl = {}
    local cols = 1
    local iconsize = 28
    for i=1,#object.spells do
        if object.spells[i].busy==true then
            table.insert(tbl, object.spells[i])
        end
    end
    table.sort(tbl, function(a,b) return a.cdtime > b.cdtime end)
    for i=1,#tbl do
        tbl[i]:ClearAllPoints()
        if i==1 then 
            tbl[i]:SetPoint("BOTTOM")
        else
            if (math.floor(math.floor((i-1)/cols)/2) == 1) then
                tbl[i]:SetPoint("BOTTOM", cols * iconsize * object.growdir, 0)
                cols = cols + 1
            else
                tbl[i]:SetPoint("BOTTOM", tbl[i-1], "TOP", 0, 0)
            end
        end
    end
end


local function UpdateAuras(unit, aurastack, framename, removeaura, count, expiration, duration, spellId, debufftype, isDebuff, caster)
    if auralist[spellId] == nil then
        for _, value in pairs(notShownAuras) do
            if value == spellId then
                return
            end
        end
    end
    
    local found, index = false, nil
    for i,v in ipairs(aurastack) do
        if v.spellId == spellId and v.caster == caster then
            found = true
            index = i
        end
    end
    if removeaura == 1 then
        if found then
            if aurastack[index].icon then 
                aurastack[index].icon:SetAlpha(0)              
                aurastack[index].icon.on = 0
                aurastack[index].active = false
            end
            found = false
        end
    else
        if not found then
            table.insert(aurastack, {spellId = spellId, caster = caster, active = true } )
            updateIcon(unit, framename, aurastack, #aurastack, spellId, count, expiration, duration, debufftype, isDebuff)
        else
            updateIcon(unit, framename, aurastack, index, spellId, count, expiration, duration, debufftype, isDebuff)
        end
    end
    
    SetPosition(aurastack, aurastack.num or 64)
end


-- Creates all frames for player (p)
local function CreateFrameForPlayer(p)
    local fpet = CreateFrame("Frame", nil, WorldFrame)
    fpet:SetWidth(SIZE.PET.WIDTH + 1)
    fpet:SetHeight(SIZE.PET.HEIGHT + 1)
    fpet:SetPoint("CENTER", 0, 0)
    local fpet1 = fpet:CreateTexture(nil, "BORDER")
    fpet1:SetAllPoints(fpet)
    fpet1:SetTexCoord(.1,.9,.1,.9)
    fpet1:SetTexture("Interface\\Icons\\" .. PLAYERPETS[0])
    fpet1.text = fpet:CreateFontString(nil, "OVERLAY")
    fpet1.text:SetFont(STANDARD_TEXT_FONT, SIZE.PET.NAMETEXTSIZE, "OUTLINE")
    fpet1.text:SetPoint("CENTER", 0, 0)
    fpet1.text:SetAlpha(0.7)
    fpet1.text:SetText("100%")
    local border = CreateFrame("frame", nil, fpet)
    border:SetPoint("TOPLEFT", -1, 1)
    border:SetPoint("BOTTOMRIGHT", 1, -1)

    local f = CreateFrame("Button", nil, WorldFrame)
    f:SetWidth(SIZE.SMALL.WIDTH)
    f:SetHeight(SIZE.SMALL.HEIGHT)
    f:SetPoint("CENTER", 0, 0)
    f.texture = f:CreateTexture(nil, "BACKGROUND", nil, -7)
    f.texture:SetAllPoints(f)
    f.texture:SetTexture(unpack(COLOR.BACKGROUND))
    f:SetFrameStrata("BACKGROUND")
    f.text = f:CreateFontString(nil, "OVERLAY")
    f.text:SetFont(STANDARD_TEXT_FONT, SIZE.SMALL.NAMETEXTSIZE, "OUTLINE")
    f.text:SetText(p.name)
    f:SetScript("OnClick", SetViewPoint)
    
    f.guid = p.guid
    local CombatFeedbackFrame = CreateFrame("Frame", nil, f)
    CombatFeedbackFrame:SetWidth(SIZE.SMALL.WIDTH)
    CombatFeedbackFrame:SetHeight(SIZE.SMALL.HEIGHT)
    CombatFeedbackFrame:SetPoint("CENTER", 0, 4)
    f.CombatFeedbackText = CombatFeedbackFrame:CreateFontString(nil, "OVERLAY")
    f.CombatFeedbackText:SetPoint("CENTER", 80, 0)
    f.CombatFeedbackText:SetFont(DAMAGE_TEXT_FONT, 18, 'OUTLINE')
    addCombatFeedback(f)

    local cla = CreateFrame("Button", nil, f)
    cla:SetWidth(SIZE.SMALL.HEIGHT)
    cla:SetHeight(SIZE.SMALL.HEIGHT)
    cla:SetPoint("LEFT", f, "LEFT", 2, -2)
    cla.texture = cla:CreateTexture(nil, "ARTWORK")
    cla.texture:SetAllPoints(cla)
    cla.texture:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
    cla.texture:SetTexCoord(unpack(_CLASS_ICON_TCOORDS["WARRIOR"]))
    cla.cooldown = CreateFrame("Cooldown", nil, cla)
    cla.cooldown:SetAllPoints(cla)
    cla.cooldown:SetReverse()

    local lowestHP = CreateFrame("frame", nil, f)
    lowestHP:SetFrameStrata("MEDIUM")
    lowestHP:SetWidth(120)
    lowestHP:SetHeight(30)
    -- lowestHP.texture = lowestHP:CreateTexture(nil, "BACKGROUND", nil, -7)
    -- lowestHP.texture:SetAllPoints(lowestHP)
    -- lowestHP.texture:SetTexture(0, 0, 0)
    lowestHP:SetPoint("TOP", cla, "TOP", 0, 24)
    lowestHP.text = lowestHP:CreateFontString(nil, "OVERLAY")
    lowestHP.text:SetFont(STANDARD_TEXT_FONT, SIZE.SMALL.NAMETEXTSIZE, "OUTLINE")
    lowestHP.text:SetText("100%")
    lowestHP.text:SetPoint("CENTER", 0, 0)
    
    local hp = CreateFrame("StatusBar", nil, f)
    hp:SetWidth(SIZE.SMALL.WIDTH - SIZE.SMALL.HEIGHT - 2)
    hp:SetHeight(SIZE.SMALL.HEALTHHEIGHT)
    hp:SetPoint("TOPLEFT", cla, "TOPRIGHT", 0, 0)
    -- hp.texture = hp:CreateTexture(nil, "BACKGROUND", nil, 7)
    -- hp.texture:SetAllPoints(hp)
    -- hp.texture:SetTexture(unpack(COLOR.HEALTH_BG))
    local hptx = hp:CreateTexture(nil, "ARTWORK", nil, 7)
    hptx:SetAllPoints(hp)
    hptx:SetTexture(BAR_TEXTURE)
    hp:SetStatusBarTexture(hptx)
    hp:SetStatusBarColor(unpack(COLOR.HEALTH))
    hp:GetStatusBarTexture():SetHorizTile(false)
    hp:GetStatusBarTexture():SetVertTile(false)
    hp.text = hp:CreateFontString(nil, "OVERLAY")
    hp.text:SetFont(STANDARD_TEXT_FONT, SIZE.SMALL.HEALTHTEXTSIZE, "OUTLINE")
    hp.text:SetPoint("CENTER", 0, 0)
    hp.text:SetText("100%")

    f.text:SetPoint("BOTTOM", hp, "TOP", 0, 2)

    
    local mp = CreateFrame("StatusBar", nil, f)
    mp:SetWidth(SIZE.SMALL.WIDTH - SIZE.SMALL.HEIGHT - 2)
    mp:SetHeight(SIZE.SMALL.HEIGHT - SIZE.SMALL.HEALTHHEIGHT - 6)
    mp:SetPoint("TOPLEFT", hp, "BOTTOMLEFT", 0, -2)
    mp:SetPoint("BOTTOMLEFT", f, "BOTTOMRIGHT", -2, 2)
    mp.texture = mp:CreateTexture(nil, "BACKGROUND", nil, 7)
    mp.texture:SetAllPoints(mp)
    mp.texture:SetTexture(1, 1, 1, 0.2)
    local mptx = mp:CreateTexture(nil, "ARTWORK", nil, 7)
    mptx:SetAllPoints(mp)
    mptx:SetTexture(1, 1, 1, 1)
    mp:SetStatusBarTexture(mptx)
    mp:SetStatusBarColor(1, 1, 1, 1)
    mp.text = mp:CreateFontString(nil, "OVERLAY")
    mp.text:SetFont(STANDARD_TEXT_FONT, SIZE.SMALL.POWERTEXTSIZE, "OUTLINE")
    mp.text:SetPoint("CENTER", 0, 0)
    mp.text:SetText("100")

    local castbg = CreateFrame("frame", nil, f)
    castbg:SetWidth(SIZE.SMALL.WIDTH-26)
    castbg:SetHeight(SIZE.SMALL.CASTBARHEIGHT)
    castbg:SetPoint("TOP", f, "BOTTOM", 0, -2)
    castbg.tex = castbg:CreateTexture(nil, "BACKGROUND", nil, 7)
    castbg.tex:SetTexture(unpack(COLOR.CASTBAR_BG))
    castbg.tex:SetAllPoints()

    local cast = CreateFrame("StatusBar", nil, castbg)
    cast:SetPoint("TOPLEFT", castbg, "TOPLEFT", 2, -2)
    cast:SetPoint("BOTTOMRIGHT", castbg, "BOTTOMRIGHT", -2, 2)
    cast.texture = cast:CreateTexture(nil, "BACKGROUND", nil, 7)
    cast.texture:SetAllPoints(cast)
    cast.texture:SetTexture(unpack(COLOR.CASTBAR_BG))
    local castt = cast:CreateTexture("CastBarTexture" .. globalCastbar, "ARTWORK", nil, 7)
    castt:SetAllPoints(cast)
    castt:SetTexture(unpack(COLOR.CASTBAR))
    cast:SetStatusBarTexture(castt)
    cast:SetStatusBarColor(unpack(COLOR.CASTBAR))
    cast:SetMinMaxValues(0, 1)
    cast:SetValue(2)
    cast.text = cast:CreateFontString("OVERLAY")
    cast.text:SetFont(STANDARD_TEXT_FONT, SIZE.SMALL.CASTBARTEXTSIZE, "OUTLINE")
    cast.text:SetPoint("LEFT", 14, 0)
    cast.text:SetText(TEXT.SUCCESS)
    cast.text:SetTextColor(unpack(COLOR.CASTBAR_TEXT))
    cast.text2 = cast:CreateFontString("OVERLAY")
    cast.text2:SetFont(STANDARD_TEXT_FONT, SIZE.SMALL.CASTBARTEXTSIZE - 2, "OUTLINE")
    cast.text2:SetPoint("RIGHT", 0, 0)
    cast.text2:SetText("0/0")
    cast.text2:SetTextColor(unpack(COLOR.CASTBAR_TEXT))
    cast.direction = 1
    globalCastbar = globalCastbar + 1
    
    local debuffs = CreateFrame('Frame', nil, f)
    debuffs:SetWidth(f:GetWidth())
    debuffs:SetHeight(f:GetHeight())
    debuffs:SetPoint('TOPLEFT', f, 'BOTTOMLEFT', 0, -SIZE.SMALL.CASTBARHEIGHT-4)
    debuffs.num = 11
    debuffs.spacing = 2
    debuffs.size = f:GetWidth()/debuffs.num
    debuffs.initialAnchor = 'TOPLEFT'
    debuffs['growth-y'] = 'DOWN'
    debuffs['growth-x'] = 'RIGHT'            
    
    local trinket = CreateFrame("Button", nil, cla)
    trinket:SetFrameStrata("MEDIUM")
    trinket:SetWidth(SIZE.SMALL.TRINKETSIZE)
    trinket:SetHeight(SIZE.SMALL.TRINKETSIZE)
    trinket:SetPoint("CENTER", cla, "BOTTOMLEFT", SIZE.SMALL.TRINKETOFFSET, SIZE.SMALL.TRINKETOFFSET)
    trinket.texture = trinket:CreateTexture("BACKGROUND")
    trinket.texture:SetAllPoints(trinket)
    trinket.texture:SetTexture("Interface\\Icons\\INV_Jewelry_TrinketPVP_02")
    trinket.cd = CreateFrame("Cooldown", nil, trinket)
    trinket.cd:SetWidth(SIZE.SMALL.TRINKETSIZE)
    trinket.cd:SetHeight(SIZE.SMALL.TRINKETSIZE)
    trinket.cd:SetPoint("CENTER", trinket, "CENTER", 0, 0)
    trinket.cd:SetFrameStrata("HIGH")
    trinket.cd:SetCooldown(0, 0)

    local sf = CreateFrame("Button", nil, WorldFrame)
    sf:SetWidth(SIZE.BIG.WIDTH)
    sf:SetHeight(SIZE.BIG.HEIGHT)
    sf:SetPoint("BOTTOMRIGHT", WorldFrame, "BOTTOM", -SIZE.BIG.FRAMEPOSITION, SIZE.BIG.FRAMEFROMBORDER)
    sf.texture = sf:CreateTexture(nil, "BACKGROUND", nil, -7)
    sf.texture:SetAllPoints(sf)
    sf.texture:SetTexture(unpack(COLOR.BACKGROUND))
    sf:SetFrameStrata("BACKGROUND")
    sf.text = sf:CreateFontString(nil, "OVERLAY")
    sf.text:SetFont(STANDARD_TEXT_FONT, SIZE.BIG.NAMETEXTSIZE, "OUTLINE")
    sf.text:SetText(p.name)

    sf.guid = p.guid
    sf.CombatFeedbackText = sf:CreateFontString(nil, "OVERLAY")
    sf.CombatFeedbackText:SetPoint("TOP", 0, SIZE.BIG.CASTBARHEIGHT+SIZE.BIG.NAMETEXTSIZE+4)
    sf.CombatFeedbackText:SetFont(DAMAGE_TEXT_FONT, 18, 'OUTLINE')
    addCombatFeedback(sf)
    
    
    local scla = CreateFrame("Button", nil, sf)
    scla:SetWidth(SIZE.BIG.HEIGHT-4)
    scla:SetHeight(SIZE.BIG.HEIGHT-4)
    scla:SetPoint("TOPLEFT", sf, "TOPLEFT", 2, -2)
    scla.texture = scla:CreateTexture("ARTWORK")
    scla.texture:SetAllPoints(scla)
    scla.texture:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
    scla.texture:SetTexCoord(unpack(_CLASS_ICON_TCOORDS["WARRIOR"]))
    scla.cooldown = CreateFrame("Cooldown", nil, scla)
    scla.cooldown:SetAllPoints(scla)
    scla.cooldown:SetReverse()
    
    local shp = CreateFrame("StatusBar", nil, sf)
    shp:SetWidth(SIZE.BIG.WIDTH - SIZE.BIG.HEIGHT - 2)
    shp:SetHeight(SIZE.BIG.HEALTHHEIGHT)
    shp:SetPoint("TOPLEFT", scla, "TOPRIGHT", 2, 0)
    shp.texture = shp:CreateTexture(nil, "BACKGROUND", nil, 7)
    shp.texture:SetAllPoints(shp)
    shp.texture:SetTexture(unpack(COLOR.HEALTH_BG))
    local shptx = shp:CreateTexture(nil, "ARTWORK", nil, 7)
    shptx:SetAllPoints(shp)
    shptx:SetTexture(unpack(COLOR.HEALTH))
    shp:SetStatusBarTexture(shptx, "ARTWORK")
    shp:SetStatusBarColor(unpack(COLOR.HEALTH))
    shp.text = shp:CreateFontString(nil, "OVERLAY")
    shp.text:SetFont(STANDARD_TEXT_FONT, SIZE.BIG.HEALTHTEXTSIZE, "OUTLINE")
    shp.text:SetPoint("CENTER", 0, 0)
    shp.text:SetText("100%")

    sf.text:SetPoint("BOTTOM", shp, "TOP", 0, 2)

    local sdebuffs = CreateFrame('Frame', nil, sf)
    sdebuffs:SetWidth(sf:GetWidth())
    sdebuffs:SetHeight(sf:GetHeight())
    sdebuffs:SetPoint('BOTTOMLEFT', sf, 'TOPLEFT', 0, SIZE.BIG.CASTBARHEIGHT+SIZE.BIG.NAMETEXTSIZE+4)
    sdebuffs.num = 12
    sdebuffs.spacing = 2
    sdebuffs.size = sf:GetWidth()/sdebuffs.num
    sdebuffs.initialAnchor = 'BOTTOMLEFT'
    sdebuffs['growth-y'] = 'UP'
    sdebuffs['growth-x'] = 'RIGHT'            
    
    local smp = CreateFrame("StatusBar", nil, sf)
    smp:SetWidth(SIZE.BIG.WIDTH - SIZE.BIG.HEIGHT - 2)
    smp:SetHeight(SIZE.BIG.HEIGHT - SIZE.BIG.HEALTHHEIGHT - 6)
    smp:SetPoint("TOPLEFT", shp, "BOTTOMLEFT", 0, -2)
    smp.texture = smp:CreateTexture(nil, "BACKGROUND", nil, 7)
    smp.texture:SetAllPoints(smp)
    smp.texture:SetTexture(1, 1, 1, 0.2)
    local smptx = smp:CreateTexture(nil, "ARTWORK", nil, 7)
    smptx:SetAllPoints(smp)
    smptx:SetTexture(1, 1, 1, 1)
    smp:SetStatusBarTexture(smptx, "ARTWORK")
    smp:SetStatusBarColor(1, 1, 1, 1)
    smp.text = smp:CreateFontString(nil, "OVERLAY")
    smp.text:SetFont(STANDARD_TEXT_FONT, SIZE.BIG.POWERTEXTSIZE, "OUTLINE")
    smp.text:SetPoint("CENTER", 0, 0)
    smp.text:SetText("100")

    local scastbg = CreateFrame("frame", nil, sf)
    scastbg:SetWidth(SIZE.BIG.WIDTH)
    scastbg:SetHeight(SIZE.BIG.CASTBARHEIGHT)
    scastbg:SetPoint("BOTTOM", sf, "TOP", 0, SIZE.BIG.CASTBARPOSITIONY)
    scastbg.tex = scastbg:CreateTexture(nil, "BACKGROUND", nil, 7)
    scastbg.tex:SetTexture(unpack(COLOR.CASTBAR_BG))
    scastbg.tex:SetAllPoints()

    local scast = CreateFrame("StatusBar", nil, sf)
    scast:SetPoint("TOPLEFT", scastbg, "TOPLEFT", 2, -2)
    scast:SetPoint("BOTTOMRIGHT", scastbg, "BOTTOMRIGHT", -2, 2)
    scast.texture = scast:CreateTexture(nil, "BACKGROUND", nil, 7)
    scast.texture:SetAllPoints(scast)
    scast.texture:SetTexture(unpack(COLOR.CASTBAR_BG))
    local scastt = scast:CreateTexture("CastBarTexture" .. globalCastbar, "ARTWORK", nil, 30)
    scastt:SetAllPoints(scast)
    scastt:SetTexture(unpack(COLOR.CASTBAR))
    scast:SetStatusBarTexture(scastt)
    scast:SetStatusBarColor(unpack(COLOR.CASTBAR))
    scast:SetMinMaxValues(0, 1)
    scast:SetValue(2)
    scast.text = scast:CreateFontString("OVERLAY")
    scast.text:SetFont(STANDARD_TEXT_FONT, SIZE.BIG.CASTBARTEXTSIZE, "OUTLINE")
    scast.text:SetPoint("CENTER", 0, 0)
    scast.text:SetText(TEXT.SUCCESS)
    scast.text:SetTextColor(unpack(COLOR.CASTBAR_TEXT))
    scast.text2 = scast:CreateFontString("OVERLAY")
    scast.text2:SetFont(STANDARD_TEXT_FONT, SIZE.SMALL.CASTBARTEXTSIZE - 2, "OUTLINE")
    scast.text2:SetPoint("RIGHT", 0, 0)
    scast.text2:SetText("0/0")
    scast.text2:SetTextColor(unpack(COLOR.CASTBAR_TEXT))
    scast.direction = 1
    globalCastbar = globalCastbar + 1

    local tf = CreateFrame("Button", nil, WorldFrame)
    tf:SetWidth(SIZE.BIG.WIDTH)
    tf:SetHeight(SIZE.BIG.HEIGHT)
    tf:SetPoint("BOTTOMLEFT", WorldFrame, "BOTTOM", SIZE.BIG.FRAMEPOSITION, SIZE.BIG.FRAMEFROMBORDER)
    tf.texture = tf:CreateTexture(nil, "BACKGROUND", nil, -7)
    tf.texture:SetAllPoints(tf)
    tf.texture:SetTexture(unpack(COLOR.BACKGROUND))
    tf:SetFrameStrata("BACKGROUND")
    tf.text = tf:CreateFontString(nil, "OVERLAY")
    tf.text:SetFont(STANDARD_TEXT_FONT, SIZE.BIG.NAMETEXTSIZE, "OUTLINE")
    tf.text:SetText(p.name)
    tf:SetScript("OnClick", SetViewPoint)

    tf.guid = p.guid
    tf.CombatFeedbackText = tf:CreateFontString(nil, "OVERLAY")
    tf.CombatFeedbackText:SetPoint("TOP", 0, SIZE.BIG.CASTBARHEIGHT+SIZE.BIG.NAMETEXTSIZE+4)
    tf.CombatFeedbackText:SetFont(DAMAGE_TEXT_FONT, 18, 'OUTLINE')
    addCombatFeedback(tf)
    
    local tcla = CreateFrame("Button", nil, tf)
    tcla:SetWidth(SIZE.BIG.HEIGHT-4)
    tcla:SetHeight(SIZE.BIG.HEIGHT-4)
    tcla:SetPoint("TOPRIGHT", tf, "TOPRIGHT", -2, -2)
    tcla.texture = tcla:CreateTexture("ARTWORK")
    tcla.texture:SetAllPoints(tcla)
    tcla.texture:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
    tcla.texture:SetTexCoord(unpack(_CLASS_ICON_TCOORDS["WARRIOR"]))
    tcla.cooldown = CreateFrame("Cooldown", nil, tcla)
    tcla.cooldown:SetAllPoints(tcla)
    tcla.cooldown:SetReverse()
    
    local thp = CreateFrame("StatusBar", nil, tf)
    thp:SetWidth(SIZE.BIG.WIDTH - SIZE.BIG.HEIGHT - 2)
    thp:SetHeight(SIZE.BIG.HEALTHHEIGHT)
    thp:SetPoint("TOPRIGHT", tcla, "TOPLEFT", -2, 0)
    thp.texture = thp:CreateTexture(nil, "BACKGROUND", nil, 7)
    thp.texture:SetAllPoints(thp)
    thp.texture:SetTexture(unpack(COLOR.HEALTH_BG))
    local thptx = thp:CreateTexture(nil, "ARTWORK", nil, 7)
    thptx:SetAllPoints(thp)
    thptx:SetTexture(unpack(COLOR.HEALTH))
    thp:SetStatusBarTexture(thptx, "ARTWORK")
    thp:SetStatusBarColor(unpack(COLOR.HEALTH))
    thp.text = thp:CreateFontString(nil, "OVERLAY")
    thp.text:SetFont(STANDARD_TEXT_FONT, SIZE.BIG.HEALTHTEXTSIZE, "OUTLINE")
    thp.text:SetPoint("CENTER", 0, 0)
    thp.text:SetText("100%")
    
    tf.text:SetPoint("BOTTOM", thp, "TOP", 0, 2)

    local tdebuffs = CreateFrame('Frame', nil, tf)
    tdebuffs:SetWidth(tf:GetWidth())
    tdebuffs:SetHeight(tf:GetHeight())
    tdebuffs:SetPoint('BOTTOMLEFT', tf, 'TOPLEFT', 0, SIZE.BIG.CASTBARHEIGHT+SIZE.BIG.NAMETEXTSIZE+4)
    tdebuffs.num = 12
    tdebuffs.spacing = 2
    tdebuffs.size = tf:GetWidth()/tdebuffs.num
    tdebuffs.initialAnchor = 'BOTTOMLEFT'
    tdebuffs['growth-y'] = 'UP'
    tdebuffs['growth-x'] = 'RIGHT'            

    local tmp = CreateFrame("StatusBar", nil, tf)
    tmp:SetWidth(SIZE.BIG.WIDTH - SIZE.BIG.HEIGHT - 2)
    tmp:SetHeight(SIZE.BIG.HEIGHT - SIZE.BIG.HEALTHHEIGHT - 6)
    tmp:SetPoint("TOPRIGHT", thp, "BOTTOMRIGHT", 0, -2)
    tmp.texture = tmp:CreateTexture(nil, "BACKGROUND", nil, 7)
    tmp.texture:SetAllPoints(tmp)
    tmp.texture:SetTexture(1, 1, 1, 0.2)
    local tmptx = tmp:CreateTexture(nil, "ARTWORK", nil, 7)
    tmptx:SetAllPoints(tmp)
    tmptx:SetTexture(1, 1, 1, 1)
    tmp:SetStatusBarTexture(tmptx, "ARTWORK")
    tmp:SetStatusBarColor(1, 1, 1, 1)
    tmp.text = tmp:CreateFontString(nil, "OVERLAY")
    tmp.text:SetFont(STANDARD_TEXT_FONT, SIZE.BIG.POWERTEXTSIZE, "OUTLINE")
    tmp.text:SetPoint("CENTER", 0, 0)
    tmp.text:SetText("100")

    local tcastbg = CreateFrame("frame", nil, tf)
    tcastbg:SetWidth(SIZE.BIG.WIDTH)
    tcastbg:SetHeight(SIZE.BIG.CASTBARHEIGHT)
    tcastbg:SetPoint("BOTTOM", tf, "TOP", 0, SIZE.BIG.CASTBARPOSITIONY)
    tcastbg.tex = tcastbg:CreateTexture(nil, "BACKGROUND")
    tcastbg.tex:SetTexture(unpack(COLOR.CASTBAR_BG))
    tcastbg.tex:SetAllPoints()
    
    local tcast = CreateFrame("StatusBar", nil, tf)
    tcast:SetPoint("TOPLEFT", tcastbg, "TOPLEFT", 2, -2)
    tcast:SetPoint("BOTTOMRIGHT", tcastbg, "BOTTOMRIGHT", -2, 2)
    tcast.texture = tcast:CreateTexture(nil, "BACKGROUND", nil, 7)
    tcast.texture:SetAllPoints(tcast)
    tcast.texture:SetTexture(unpack(COLOR.CASTBAR_BG))
    local tcastt = tcast:CreateTexture("CastBarTexture" .. globalCastbar, "ARTWORK", nil, 30)
    tcastt:SetAllPoints(tcast)
    tcastt:SetTexture(unpack(COLOR.CASTBAR))
    tcast:SetStatusBarTexture(tcastt)
    tcast:SetStatusBarColor(unpack(COLOR.CASTBAR))
    tcast:SetMinMaxValues(0, 1)
    tcast:SetValue(2)
    tcast.text = tcast:CreateFontString("OVERLAY")
    tcast.text:SetFont(STANDARD_TEXT_FONT, SIZE.BIG.CASTBARTEXTSIZE, "OUTLINE")
    tcast.text:SetPoint("CENTER", 0, 0)
    tcast.text:SetText(TEXT.SUCCESS)
    tcast.text:SetTextColor(unpack(COLOR.CASTBAR_TEXT))
    tcast.text2 = tcast:CreateFontString("OVERLAY")
    tcast.text2:SetFont(STANDARD_TEXT_FONT, SIZE.SMALL.CASTBARTEXTSIZE - 2, "OUTLINE")
    tcast.text2:SetPoint("RIGHT", 0, 0)
    tcast.text2:SetText("0/0")
    tcast.text2:SetTextColor(unpack(COLOR.CASTBAR_TEXT))
    tcast.direction = 1
    globalCastbar = globalCastbar + 1
    
    p.cooldowns = CreateFrame("frame", nil, WorldFrame)
    p.cooldowns:SetWidth(28)
    p.cooldowns:SetHeight(28)
    p.cooldowns:SetPoint("CENTER", 0, 0)
    p.cooldowns.spells = {}

    p.fsmall.spells = {}
    p.fself.spells = {}
    p.ftarget.spells = {}

    p.fsmall.spells.SetAlpha = function(x) end
    p.fself.spells.SetAlpha = function(x) end
    p.ftarget.spells.SetAlpha = function(x) end

    for i = 0, 3, 1 do
        local smalls = CreateFrame("Button", nil, f)
        smalls:SetWidth(SIZE.SMALL.SPELLSIZE)
        smalls:SetHeight(SIZE.SMALL.SPELLSIZE)
        smalls:SetPoint("CENTER", f, "RIGHT")
        smalls.texture = smalls:CreateTexture("BACKGROUND")
        smalls.texture:SetAllPoints(smalls)
        smalls.texture:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
        smalls.texture:SetAlpha(0)
        smalls.interrupttexture = smalls:CreateTexture("OVERLAY")
        smalls.interrupttexture:SetAllPoints(smalls)
        smalls.interrupttexture:SetAlpha(0)

        local targets = CreateFrame("Button", nil, tf)
        targets:SetWidth(SIZE.BIG.SPELLSIZE)
        targets:SetHeight(SIZE.BIG.SPELLSIZE)
        targets:SetPoint("LEFT", tf, "RIGHT", 2 + (2 + SIZE.BIG.SPELLSIZE) * i, 0)
        targets.texture = targets:CreateTexture("ARTWORK")
        targets.texture:SetAllPoints(targets)
        targets.texture:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
        targets.texture:SetAlpha(0)
        targets.interrupttexture = targets:CreateTexture("OVERLAY")
        targets.interrupttexture:SetAllPoints(targets)
        targets.interrupttexture:SetAlpha(0)

        local selfs = CreateFrame("Button", nil, sf)
        selfs:SetWidth(SIZE.BIG.SPELLSIZE)
        selfs:SetHeight(SIZE.BIG.SPELLSIZE)
        selfs:SetPoint("RIGHT", sf, "LEFT", -2 - (2 + SIZE.BIG.SPELLSIZE) * i, 0)
        selfs.texture = selfs:CreateTexture("ARTWORK")
        selfs.texture:SetAllPoints(selfs)
        selfs.texture:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
        selfs.texture:SetAlpha(0)
        selfs.interrupttexture = selfs:CreateTexture("OVERLAY")
        selfs.interrupttexture:SetAllPoints(selfs)
        selfs.interrupttexture:SetAlpha(0)

        smalls:Show()
        targets:Show()
        selfs:Show()

        p.fsmall.spells[i] = smalls
        p.fself.spells[i] = selfs
        p.ftarget.spells[i] = targets
    end

    p.fsmall.main = f
    p.fsmall.pet = fpet
    p.fsmall.pet1 = border
    p.fsmall.pettext = fpet1
    p.fsmall.health = hp
    p.fsmall.power = mp
    p.fsmall.class = cla
    p.fsmall.cast = cast
    p.fsmall.castbg = castbg
    p.fsmall.trinket = trinket
    p.fsmall.Debuffs = debuffs
    p.fsmall.lowestHP = lowestHP

    cast:Show()
    mp:Show()
    hp:Show()
    cla:Show()
    trinket:Show()
    lowestHP:Show()
    fpet:Show()
    fpet1:Show()
    f:Show()

    p.fself.main = sf
    p.fself.health = shp
    p.fself.power = smp
    p.fself.class = scla
    p.fself.cast = scast
    p.fself.castbg = scastbg
    p.fself.Debuffs = sdebuffs

    scast:Show()
    shp:Show()
    smp:Show()
    scla:Show()
    sf:Hide()

    p.ftarget.main = tf
    p.ftarget.health = thp
    p.ftarget.power = tmp
    p.ftarget.class = tcla
    p.ftarget.cast = tcast
    p.ftarget.castbg = tcastbg
    p.ftarget.Debuffs = tdebuffs

    tcast:Show()
    thp:Show()
    tmp:Show()
    tcla:Show()
    tf:Hide()

    f:SetScript("OnUpdate", UpdateFrame)
end

-- Creates new player named (value) without frames
local function CreatePlayer(value)
    local _player = {}

    _player.name = "UNNAMED"
    _player.guid = value
    _player.pet = "-1"
    _player.health = 1
    _player.maxhealth = 1
    _player.minhealth = -1
    _player.powertype = 1
    _player.power = 1
    _player.maxpower = 1
    _player.status = 1
    _player.team = 0
    _player.target = nil
    _player.auras = {}
    _player.spells = {
        [0] = {
            ["id"] = 0,
            ["tim"] = 0,
            ["interrupted"] = false
              },
        [1] = {
            ["id"] = 0,
            ["tim"] = 0,
            ["interrupted"] = false
              },
        [2] = {
            ["id"] = 0,
            ["tim"] = 0,
            ["interrupted"] = false
              },
        [3] = {
            ["id"] = 0,
            ["tim"] = 0,
            ["interrupted"] = false
              }
    }

    _player.fsmall = {}
    _player.fself = {}
    _player.ftarget = {}

    return _player
end

-- Resets addon completely
local function Reset()
    if (ATPlayers ~= nil) then
        for _, p in pairs(ATPlayers) do
            p.fsmall.main:Hide()
            p.fself.main:Hide()
            p.ftarget.main:Hide()
            p.fsmall.pet:Hide()
            for _, barname in pairs(ALLBARS) do
                p[barname].main:Hide()
            end
            
            for i, v in pairs(p.cooldowns.spells) do
                v:Hide()
                v.busy = false
                v.timestamp = 0
				v.spellid = 0
                v:SetScript("OnUpdate", nil)
                v:ClearAllPoints()
            end
        end
    end

    ATPlayers = {}
    watch = nil
    hideui = nil
    UIParent:Show()
    CombatLogClearEntries()
    TimeFrame:SetScript("OnUpdate", nil)
    TimeFrame:Hide()
end

-- Force player data full update for all ATPlayers in arena
local function ForceUpdate()
    SendChatMessage(".spect reset", "GUILD");
end

-- Redraws class/cc icon for player (pla)
local function RedrawClassIcon(pla)
    local highAura = nil
    local highAuraLevel = 0
    
    for i, aura in ipairs(ATPlayers[pla].fsmall.Debuffs) do
        if aura.active and auralist[aura.spellId] ~= nil then
            if auralist[aura.spellId] > highAuraLevel then
                highAura = aura
                highAuraLevel = auralist[aura.spellId]
            end
        end
    end

    if (highAura == nil) then
        for _, barname in pairs(ALLBARS) do
            ATPlayers[pla][barname].class.cooldown:Hide()
            ATPlayers[pla][barname].class.texture:SetTexture([[Interface\Glues\CharacterCreate\UI-CharacterCreate-Classes]])
            ATPlayers[pla][barname].class.texture:SetTexCoord(0,1,0,1)
            local t = _CLASS_ICON_TCOORDS[ClassToTexture(ATPlayers[pla].class)]
            if t then
                ATPlayers[pla][barname].class.texture:SetTexture([[Interface\Glues\CharacterCreate\UI-CharacterCreate-Classes]])
                local left, right, top, bottom = unpack(t)
                left = left + (right - left) * 0.08; right = right - (right - left) * 0.08; top = top + (bottom - top) * 0.08; bottom = bottom - (bottom - top) * 0.08
                ATPlayers[pla][barname].class.texture:SetTexCoord(left, right, top, bottom)
            end
        end
    else
        local name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo(highAura.spellId)
        for _, barname in pairs(ALLBARS) do
            if highAura.icon.cd.cdStart ~= nil then
                ATPlayers[pla][barname].class.cooldown:SetCooldown(highAura.icon.cd.cdStart, highAura.icon.cd.cdDuration)
                ATPlayers[pla][barname].class.cooldown:Show()
            else
                ATPlayers[pla][barname].class.cooldown:Hide()
            end
            ATPlayers[pla][barname].class.texture:SetTexture(icon)
            ATPlayers[pla][barname].class.texture:SetTexCoord(.1,.9,.1,.9)
        end
    end
end

-- Used to set current power/health (field) for player (target) to (value)
local function UpdateValue(target, field, value)
    ATPlayers[target][field] = value
    for _, barname in pairs(ALLBARS) do
        ATPlayers[target][barname][field]:SetValue(value)
    end

    if (field == "health") then
        if ATPlayers[target]["minhealth"] == -1 then
            ATPlayers[target]["minhealth"] = math.ceil(ATPlayers[target].health / ATPlayers[target]["maxhealth"] * 100)
        else 
            if ATPlayers[target]["minhealth"] > math.ceil(ATPlayers[target].health / ATPlayers[target]["maxhealth"] * 100) then
                ATPlayers[target]["minhealth"] = math.ceil(ATPlayers[target].health / ATPlayers[target]["maxhealth"] * 100)
            end
        end
        local newtext
        if (ATPlayers[target].status == 0) then
            newtext = "DEAD"
        else
            newtext = math.ceil(ATPlayers[target].health / ATPlayers[target]["maxhealth"] * 100) .. "%"
        end
        for _, barname in pairs(ALLBARS) do
            ATPlayers[target][barname].health.text:SetText(newtext)
        end
        ATPlayers[target].fsmall.lowestHP.text:SetText(ATPlayers[target].minhealth .. "%")
    else
        for _, barname in pairs(ALLBARS) do
            ATPlayers[target][barname].power.text:SetText(value)
        end
    end
end

-- Used to set max power/health (field) for player (target) to (value)
local function UpdateMaxValue(target, field, value)
    ATPlayers[target]["max" .. field] = value
    for _, barname in pairs(ALLBARS) do
        ATPlayers[target][barname][field]:SetMinMaxValues(0, value)
    end

    if (field == "health") then
        local newtext
        if (ATPlayers[target].status == 0) then
            newtext = "DEAD"
        else
            newtext = math.ceil(ATPlayers[target].health / ATPlayers[target]["maxhealth"] * 100) .. "%"
        end
        for _, barname in pairs(ALLBARS) do
            ATPlayers[target][barname].health.text:SetText(newtext)
        end
    end
end

local function UpdateHealthBarColor(target)
    for _, barname in pairs(ALLBARS) do
        ATPlayers[target][barname].health:SetStatusBarColor(unpack(CLASS_COLORS[ClassToTexture(ATPlayers[target].class)]))
        ATPlayers[target][barname].health:GetStatusBarTexture():SetTexture(BAR_TEXTURE)
    end
end

-- Used to set current power type for player (target) to (value)
local function UpdatePowerType(target, value)
    for _, barname in pairs(ALLBARS) do
        local frame = ATPlayers[target][barname].power
        if (value == 0) then -- mana
            frame:GetStatusBarTexture():SetTexture(BAR_TEXTURE)
            --frame:GetStatusBarTexture():SetTexture(unpack(COLOR.MANA))
            frame:SetStatusBarColor(unpack(COLOR.MANA))
            frame.texture:SetTexture(unpack(COLOR.MANA_BG))
        elseif (value == 1) then -- rage
            frame:GetStatusBarTexture():SetTexture(BAR_TEXTURE)
            --frame:GetStatusBarTexture():SetTexture(unpack(COLOR.RAGE))
            frame:SetStatusBarColor(unpack(COLOR.RAGE))
            frame.texture:SetTexture(unpack(COLOR.RAGE_BG))
        elseif (value == 3) then -- energy
            frame:GetStatusBarTexture():SetTexture(BAR_TEXTURE)
            --frame:GetStatusBarTexture():SetTexture(unpack(COLOR.ENERGY))
            frame:SetStatusBarColor(unpack(COLOR.ENERGY))
            frame.texture:SetTexture(unpack(COLOR.ENERGY_BG))
        elseif (value == 6) then -- runic power
            frame:GetStatusBarTexture():SetTexture(BAR_TEXTURE)
            --frame:GetStatusBarTexture():SetTexture(unpack(COLOR.RUNICPOWER))
            frame:SetStatusBarColor(unpack(COLOR.RUNICPOWER))
            frame.texture:SetTexture(unpack(COLOR.RUNICPOWER_BG))
        else
            frame:GetStatusBarTexture():SetTexture(1, 1, 1, 1)
            frame:SetStatusBarColor(1, 1, 1, 1)
            frame.texture:SetTexture(1, 1, 1, 0.2)
        end
    end
end

-- Used to set current target of (target) to player (value)
local function UpdateTarget(target, value)
    if (tonumber(value) == 0) then
        if (target == watch) then
            if (ATPlayers[watch].target ~= nil) then
                if (ATPlayers[ATPlayers[watch].target] ~= nil) then
                    ATPlayers[ATPlayers[watch].target].ftarget.main:Hide()
                end
            end
        end

        ATPlayers[target].target = nil
    else
        if (target == watch) then
            if (ATPlayers[watch].target ~= nil) then
                if (ATPlayers[ATPlayers[watch].target] ~= nil) then
                    ATPlayers[ATPlayers[watch].target].ftarget.main:Hide()
                end
            end
            if (ATPlayers[value] ~= nil) then
                ATPlayers[value].ftarget.main:Show()
            end
        end

        ATPlayers[target].target = value
    end
end

-- Used to set status (dead/alive) (value) for player (target)
local function UpdateStatus(target, value)
    ATPlayers[target].status = value
    local newalpha = 1
    if (value == 0) then
        newalpha = 0.5
    end

    for _, barname in pairs(ALLBARS) do
        for __, f in pairs(ATPlayers[target][barname]) do
            f:SetAlpha(newalpha)
        end
    end
end

-- Used to set team (value) for player (target)
local function UpdateTeam(target, value)
    ATPlayers[target].team = value
    RealignFrames()
end

-- Used to set class (value) for player (target)
local function UpdateClass(target, value)
    ATPlayers[target].class = value
    if ATPlayers[target].name then
        classes[ATPlayers[target].name] = ClassToTexture(value)
    end
    RedrawClassIcon(target)
end

-- Redraw spell frame (slot) for player (target)
local function RedrawSpellFrame(target, slot)
    if (ATPlayers[target].spells[slot].id ~= 0) then
        local icon = select(3, GetSpellInfo(ATPlayers[target].spells[slot].id))

        for _, barname in pairs(ALLBARS) do
            ATPlayers[target][barname].spells[slot].texture:SetTexture(icon)
            ATPlayers[target][barname].spells[slot].texture:SetTexCoord(.1,.9,.1,.9)
        end
    end
end

-- Update spell frame (slot) to show spell (id) for player (target), fades over time (duration)
local function SetSpell(target, slot, id, duration, interrupted)
    ATPlayers[target].spells[slot].id = id
    ATPlayers[target].spells[slot].tim = duration
    ATPlayers[target].spells[slot].interrupted = interrupted

    RedrawSpellFrame(target, slot)
end

-- Update current casted spell (id) with cast time (casttime) for player (target)
local function UpdateSpell(target, id, casttime)
    local realtime = casttime
    if casttime < 0 then
        realtime = -casttime
    end

    local name, rank, icon, cost, isFunnel, powerType, _, minRange, maxRange = GetSpellInfo(id)
    SetSpell(target, 3, ATPlayers[target].spells[2].id, ATPlayers[target].spells[2].tim, ATPlayers[target].spells[2].interrupted)
    SetSpell(target, 2, ATPlayers[target].spells[1].id, ATPlayers[target].spells[1].tim, ATPlayers[target].spells[1].interrupted)
    SetSpell(target, 1, ATPlayers[target].spells[0].id, ATPlayers[target].spells[0].tim, ATPlayers[target].spells[0].interrupted)
    SetSpell(target, 0, id, SPELLDISPLAYTIME, false)

    for _, barname in pairs(ALLBARS) do
        ATPlayers[target][barname].cast:SetValue(select(2, ATPlayers[target][barname].cast:GetMinMaxValues()) + 1)
        ATPlayers[target][barname].cast:SetAlpha(0)
        ATPlayers[target][barname].castbg:SetAlpha(0)
    end
    if casttime > 0 or casttime < 0 then
        for _, barname in pairs(ALLBARS) do
            ATPlayers[target][barname].cast.texture:SetTexture(unpack(COLOR.CASTBAR_BG))
            ATPlayers[target][barname].cast:SetStatusBarColor(unpack(COLOR.CASTBAR))
            ATPlayers[target][barname].cast:GetStatusBarTexture():SetTexture(unpack(COLOR.CASTBAR))
            ATPlayers[target][barname].cast.text:SetText(name)
            ATPlayers[target][barname].cast.text:SetTextColor(unpack(COLOR.CASTBAR_TEXT))
            ATPlayers[target][barname].cast.icon = ATPlayers[target][barname].cast:CreateTexture(ATPlayers[target][barname].cast, 'OVERLAY')
            ATPlayers[target][barname].cast.icon:SetSize(24, 24)
            ATPlayers[target][barname].cast.icon:SetPoint('CENTER', ATPlayers[target][barname].cast, 'LEFT')
            ATPlayers[target][barname].cast.icon:SetTexture(icon)
            ATPlayers[target][barname].cast.text2:SetTextColor(unpack(COLOR.CASTBAR_TEXT))
            if casttime > 0 then
                ATPlayers[target][barname].cast.direction = 1
            else
                ATPlayers[target][barname].cast.direction = -1
            end
            ATPlayers[target][barname].cast:SetMinMaxValues(0, realtime / 1000)
            if casttime > 0 then
                ATPlayers[target][barname].cast:SetValue(0)
            else
                ATPlayers[target][barname].cast:SetValue(realtime / 1000)
            end
            ATPlayers[target][barname].cast:SetAlpha(1) 
            ATPlayers[target][barname].castbg:SetAlpha(1)
        end
    end
    
    if (pvptrinket[id] ~= nil) then
        ATPlayers[target].fsmall.trinket.cd:SetCooldown(GetTime(), pvptrinket[id])
    end
end

-- Interrupts spell (id) for player (target)
local function InterruptSpell(target, id)
    if (ATPlayers[target].spells[0].id == id) then
        local goal = select(2, ATPlayers[target].fsmall.cast:GetMinMaxValues())
        local current = ATPlayers[target].fsmall.cast:GetValue()
        local direction = ATPlayers[target].fsmall.cast.direction
        if direction < 0 then
            goal = 0
        end
        
        if (current < goal and direction > 0) or (current > goal and direction < 0) then
            ATPlayers[target].spells[0].interrupted = true
            RedrawSpellFrame(target, 0)
            for _, barname in pairs(ALLBARS) do
                ATPlayers[target][barname].cast.texture:SetTexture(unpack(COLOR.CASTBAR_INTERRUPT))
                ATPlayers[target][barname].cast:SetStatusBarColor(unpack(COLOR.CASTBAR_INTERRUPT))
                ATPlayers[target][barname].cast:GetStatusBarTexture():SetTexture(unpack(COLOR.CASTBAR_INTERRUPT))
                ATPlayers[target][barname].cast.text:SetTextColor(unpack(COLOR.CASTBAR_INTERRUPT_TEXT))
                ATPlayers[target][barname].cast.text:SetText(TEXT.INTERRUPTED)
                ATPlayers[target][barname].cast.text2:SetText("")
                ATPlayers[target][barname].cast.direction = 1
                ATPlayers[target][barname].cast:SetMinMaxValues(0, 0.7)
                ATPlayers[target][barname].cast:SetValue(0)
                ATPlayers[target][barname].cast:SetAlpha(1)
                ATPlayers[target][barname].castbg:SetAlpha(1)
                ATPlayers[target][barname].cast.icon:Hide()
            end
        end
    end
end

-- Cancels spell (id) for player
local function CancelSpell(target, id)
    if (ATPlayers[target].spells[0].id == id) then
        if (ATPlayers[target].fsmall.cast:GetValue() < select(2, ATPlayers[target].fsmall.cast:GetMinMaxValues())) then
            for _, barname in pairs(ALLBARS) do
                ATPlayers[target][barname].cast:SetMinMaxValues(0, 1)
                ATPlayers[target][barname].cast:SetValue(2)
                ATPlayers[target][barname].cast:SetAlpha(0)
                ATPlayers[target][barname].castbg:SetAlpha(0)
                ATPlayers[target][barname].cast.icon:Hide()
            end
        end
    end
end

function SetEndTime(newTime)
    TimeFrame.time = newTime
    TimeFrame:Show()
    
    TimeFrame:SetScript("OnUpdate", function(self, elapsed)
        self.time = self.time - elapsed
        if self.time < 0 then
            self.time = 0
            self:SetScript("OnUpdate", nil)
        end
        
        seconds = math.floor(self.time % 60)
        
        if seconds < 10 then
            seconds = "0" .. seconds
        end
        
        self.text:SetText(math.floor(self.time / 60) .. ":" .. seconds)
    end)
end

local function UpdateName(target, value)
    ATPlayers[target].name = value

    for _, barname in pairs(ALLBARS) do
        local aaa = ATPlayers[target]
        ATPlayers[target][barname].main.text:SetText(value)
    end
end

local function UpdatePet(target, value)
    ATPlayers[target].pet = value
    ATPlayers[target].fsmall.pettext.text:SetText(value .. "%")
    
    RealignFrames()
    
    if (value <= "0") then
        ATPlayers[target].fsmall.pet:Hide()
    else
        ATPlayers[target].fsmall.pet:Show()
    end
end

local function UpdatePetTexture(target, value)
    ATPlayers[target].fsmall.pettext:SetTexture("Interface\\Icons\\" .. PLAYERPETS[value])
end

local function ResetCooldowns(target)
	for i, v in pairs(ATPlayers[target].cooldowns.spells) do
        v:Hide()
        v.busy = false
        v.timestamp = 0
		v.spellid = 0
        v:SetScript("OnUpdate", nil)
        v:ClearAllPoints()
    end
	Resort(ATPlayers[target].cooldowns)
end

local function RemoveCooldown(target, spell)
	for i, v in pairs(ATPlayers[target].cooldowns.spells) do
		if (v.busy == true and v.spellid == spell) then
			v:Hide()
			v.busy = false
			v.timestamp = 0
			v.spellid = 0
			v:SetScript("OnUpdate", nil)
			v:ClearAllPoints()
			Resort(ATPlayers[target].cooldowns)
			return
		end
    end
end

local function AddCooldown(target, spell, cooldown, maxcooldown)
    if (GetTableSize(ATPlayers) > 6) then
        for _, barname in pairs(ALLBARS) do
            ATPlayers[target][barname].class.cooldown:Hide()
        end
        
        return
    end

    if cooldown < 20 or cooldown > 900 or maxcooldown < cooldown or maxcooldown > 900 then
        return
    end
    
    local isFunnel = select(5, GetSpellInfo(spell))
    if isFunnel then return end

	RemoveCooldown(target, spell)
    
    local frm = getFree(ATPlayers[target].cooldowns)
    frm.icon:SetTexture(select(3,GetSpellInfo(spell)))
    frm.timestamp = GetTime()+cooldown-maxcooldown
    
    frm.cooldownFrame:SetCooldown(GetTime()+cooldown-maxcooldown, maxcooldown)
    frm.duration = maxcooldown
    frm.cdtime = cooldown
	frm.spellid = spell
    frm:Show()
    
    frm:SetPoint("BOTTOM")
    frm:SetScript("OnUpdate", function(self, elapsed)
        if not self.st then self.st = 0 end
        self.st = self.st + elapsed
        if self.st > .05 then
            self.cdtime = self.timestamp + self.duration - GetTime()
            if self.cdtime <= 0 then
                self.busy = false
                self.cdtime = 0
                self.timestamp = 0
				self.spellid = 0
                self:SetPoint("BOTTOM")
                self:Hide()
                Resort(ATPlayers[target].cooldowns)
            end
            Resort(ATPlayers[target].cooldowns)
        end
    end)
    Resort(ATPlayers[target].cooldowns)
end

-- Take parsed command (prefix, value) and apply to player (target)
local function Execute(target, prefix, ...)
    if not IsPlayerGUID(target) then
        return
    end

    local value = ...
    if (ATPlayers[target] == nil) then
        ATPlayers[target] = CreatePlayer(target)
        CreateFrameForPlayer(ATPlayers[target])
        ForceUpdate()
    end

    -- UpdateSelfHealthBar()

    if (prefix == "CHP") then
        UpdateValue(target, "health", tonumber(value))
    elseif (prefix == "MHP") then
        UpdateMaxValue(target, "health", tonumber(value))
    elseif (prefix == "CPW") then
        UpdateValue(target, "power", tonumber(value))
    elseif (prefix == "MPW") then
        UpdateMaxValue(target, "power", tonumber(value))
    elseif (prefix == "PWT") then
        UpdatePowerType(target, tonumber(value))
    elseif (prefix == "TEM") then
        UpdateTeam(target, tonumber(value))
    elseif (prefix == "STA") then
        UpdateStatus(target, tonumber(value))
    elseif (prefix == "TRG") then
        UpdateTarget(target, value)
    elseif (prefix == "CLA") then
        UpdateClass(target, tonumber(value))
        UpdateHealthBarColor(target)
    elseif (prefix == "SPE") then
        local casttime = tonumber(strsub(value, strfind(value, ",") + 1))
        if (casttime == 99999) then
            InterruptSpell(target, tonumber(strsub(value, 1, strfind(value, ",") - 1)))
        elseif (casttime == 99998) then
            CancelSpell(target, tonumber(strsub(value, 1, strfind(value, ",") - 1)))
        else
            UpdateSpell(target, tonumber(strsub(value, 1, strfind(value, ",") - 1)), casttime)
        end
    elseif (prefix == "ACD") then
		local spid, spcd, spmaxcd = strsplit(",", value)
        AddCooldown(target, tonumber(spid), tonumber(spcd), tonumber(spmaxcd))
    elseif (prefix == "RCD") then
        RemoveCooldown(target, tonumber(value))
	elseif (prefix == "CDC") then
		ResetCooldowns(target)
    elseif (prefix == "RES") then
        ResetAuras(ATPlayers[target].fsmall.Debuffs)
        ResetAuras(ATPlayers[target].ftarget.Debuffs)
        ResetAuras(ATPlayers[target].fself.Debuffs)
    elseif (prefix == "AUR") then
        UpdateAuras(target, ATPlayers[target].fsmall.Debuffs, "small", ...)
        UpdateAuras(target, ATPlayers[target].ftarget.Debuffs, "target", ...)
        UpdateAuras(target, ATPlayers[target].fself.Debuffs, "self", ...)
        RedrawClassIcon(target)
    elseif (prefix == "TIM") then
        SetEndTime(tonumber(value))
    elseif (prefix == "NME") then
        UpdateName(target, value)
    elseif (prefix == "PHP") then
        UpdatePet(target, value)
    elseif (prefix == "PET") then
        UpdatePetTexture(target, tonumber(value))
    else
        DEFAULT_CHAT_FRAME:AddMessage("ARENASPECTATOR: Unhandled prefix " .. prefix .. ". Try to update to newer version.")
    end
end

-- Takes server data (data) from CHAT_MSG_ADDON, seperates commands and sends them to Execute
local function ParseCommands(data)
    local pos = 1
    local stop = 1
    local target = nil
    
    if data:find(';AUR=') then
        local tar, data = strsplit(";", data)
        local _, data2 = strsplit("=", data)
        local aremove, astack, aexpiration, aduration, aspellId, adebyfftype, aisdebuff, acaster = strsplit(",", data2)
        Execute(tar, "AUR", tonumber(aremove), tonumber(astack), tonumber(aexpiration), tonumber(aduration), tonumber(aspellId), tonumber(adebyfftype), tonumber(aisdebuff), acaster)
        return
    end

    stop = strfind(data, ";", pos)
    target = strsub(data, 1, stop - 1)
    pos = stop + 1

    repeat
        stop = strfind(data, ";", pos)
        if (stop ~= nil) then
            local command = strsub(data, pos, stop - 1)
            pos = stop + 1

            local prefix = strsub(command, 1, strfind(command, "=") - 1)
            local value = strsub(command, strfind(command, "=") + 1)

            Execute(target, prefix, value)
        end
    until stop == nil
end

local function ACPEC_ShowOutdatedAddonVersion()
    StaticPopupDialogs["ARENASPECTATOR_OUTDATED"] = {
        text = "Your version of Arena-Spectator UI is outdated. Please visit http://sunwell.pl to download last version.",
        button1 = "Ok",
        whileDead = true,
        timeout = 0,
        hideOnEscape = false,
        preferredIndex = 3,
    }
    
    StaticPopup_Show("ARENASPECTATOR_OUTDATED")
end

-- All incoming event handler and distributer
local function EventHandler(self, event, arg1, arg2, arg3, arg4)
    if (event == "PLAYER_LOGIN") then
        SendChatMessage(".spect version " .. GetAddOnMetadata("SunwellAS", "Version") or "0", "GUILD");
    end

    if (event == "PLAYER_ENTERING_WORLD") then
        Reset()
        toggle:Hide()
        -- UpdateSelfHealthBar()
		specingEnabled = false
    end
    
    if (event == "CHAT_MSG_ADDON") and (arg1 == "ASSUN") and (arg3 == "WHISPER") and (arg4 == "") and (arg2 == "OUTDATED") then
        ACPEC_ShowOutdatedAddonVersion()
    end
    
    -- if IsActiveBattlefieldArena() then
        if (event == "CHAT_MSG_ADDON") then
            if ((arg1 == "ASSUN") and (arg3 == "WHISPER") and (arg4 == "")) then
				if (arg2 == "ENABLE") then
					specingEnabled = true
				elseif (arg2 == "REQUESTRESET") then
					ForceUpdate()
				elseif (specingEnabled == true) then
					ParseCommands(arg2)
					toggle:Show()
					if hideui == nil then
						hideui = true
						UIParent:Hide()
					end
				end
            end
        end
    -- end

    if event == "ADDON_LOADED" then
        updateScoreBoardFrame()
        if tournamentMode then
            scoreFrame:Show()
        end
    end

    -- if GetBattlefieldWinner() ~= nil and tournamentMode then
    --     teamscore[GetBattlefieldWinner()] = teamscore[GetBattlefieldWinner()] + 1
    --     updateScoreBoardFrame()
    -- end
end

-- Show/Hide button OnClick event
local function ToggleUI()
    if (hideui == false) then
        hideui = true
        UIParent:Hide()
    else
        hideui = false
        UIParent:Show()
    end
end

-- Checks if UI needs to be hidden fast (to fix esc toggling UI)
local function CheckUIVisibility(self, elapsed)
    if ( GetBattlefieldWinner() ) then
        UIParent:Show()
    elseif ((hideui == true) and (UIParent:IsVisible())) then
        UIParent:Hide()
    end
end

-- Add dropdown button to dropdown menu
function ASPEC_addDropDownMenuButton(uid, dropdown, index, title, usable, onClick, hint)
  if (not UnitPopupMenus[dropdown]) then return end
  tinsert(UnitPopupMenus[dropdown],index,uid);
  if (hint) then
    UnitPopupButtons[uid] = { text = title, dist = 0, tooltip = hint};
  else
    UnitPopupButtons[uid] = { text = title, dist = 0};
  end
  ASPEC_USER_DROPDOWNBUTTONS[uid] = {func = function(self)
      onClick(self,UIDROPDOWNMENU_OPEN_MENU.name,UIDROPDOWNMENU_OPEN_MENU.unit,UIDROPDOWNMENU_OPEN_MENU.server);
    end, enabled = usable};
end
ASPEC_USER_DROPDOWNBUTTONS = {};
local default_UIDropDownMenu_AddButton = UIDropDownMenu_AddButton;
UIDropDownMenu_AddButton = function(info, level)
  if(ASPEC_USER_DROPDOWNBUTTONS[info.value]) then
    local dropdownFrame = getglobal(UIDROPDOWNMENU_INIT_MENU);
    info.func = ASPEC_USER_DROPDOWNBUTTONS[info.value].func;
  end;
  default_UIDropDownMenu_AddButton(info,level);
end;

function ASPEC_try_spectate(self, name, unit, server)
    SendChatMessage(".spect spectate " .. name, "GUILD");
end

-- This is to keep track when to overtake WHO_LIST_UPDATE
ASPEC_WhoTime = 0
ASPEC_TemporaryUnsubscribed = false
function ASPEC_RecentWho()
    return (time() - ASPEC_WhoTime < 3)
end

-- Do not show /who frame if we requested the /who
function ASPEC_FriendsFrame_OnEvent(...)
    if event == "WHO_LIST_UPDATE" and ASPEC_RecentWho() then
        ASPEC_HandleWhoResult()
    else
        ASPEC_original_FriendsFrame_OnEvent(...)
    end
end
ASPEC_original_FriendsFrame_OnEvent = FriendsFrame_OnEvent;
FriendsFrame_OnEvent = ASPEC_FriendsFrame_OnEvent;

ASPEC_ArenaZones = {"Nagrand Arena", "Blade's Edge Arena", "Ruins of Lordaeron", "Dalaran Arena", "The Ring of Valor"}
if GetLocale() == "deDE" then
elseif GetLocale() == "frFR" then
elseif GetLocale() == "ruRU" then
elseif GetLocale() == "esES" then
end

-- Check if zone is within arena (by name)
function ASPEC_IsArenaZone(zone)
    for i,v in pairs(ASPEC_ArenaZones) do
        if v == zone then
            return true
        end
    end
    return false
end

-- Called when subscribe target is in arena (can be called multiple times)
function ASPEC_On_Subscribe_Target_In_Arena()
    StaticPopupDialogs["ARENASPECTATOR_ON_SUBSCRIBE_IN_ARENA"] = {
        text = ASPEC_Subscribe_Target .. " has entered arena.",
        button1 = "Spectate",
        button2 = "Cancel",
        OnAccept = function()
            ASPEC_try_spectate(nil, ASPEC_Subscribe_Target, nil, nil)
        end,
        OnCancel = function()
            ASPEC_UnsubscribeFull()
        end,
        whileDead = true,
        timeout = 0,
        hideOnEscape = false,
        preferredIndex = 3,
    }

    ASPEC_UnsubscribeTmp()

    inArena = IsActiveBattlefieldArena() or specingEnabled
    if not inArena then
        StaticPopup_Show("ARENASPECTATOR_ON_SUBSCRIBE_IN_ARENA")
    end
end

-- Handle WHO_LIST_UPDATE
function ASPEC_HandleWhoResult()
    ASPEC_WhoTime = 0 -- To prevent hijacking any /who by player
    local count = GetNumWhoResults()
    for i = 1, count do
        local name, _, _, _, _, zone = GetWhoInfo(i)
        if name == ASPEC_Subscribe_Target and ASPEC_IsArenaZone(zone) then
            ASPEC_On_Subscribe_Target_In_Arena()
        end
    end
end

-- Send /who
function ASPEC_QueryWho(name)
    ASPEC_WhoTime = time() -- Keep track of last who
    SetWhoToUI(1) -- To prevent /who going to chat frame
    SendWho('n-"' .. name .. '"')
end

ASPEC_Subscribe_Target = ''
ASPEC_WhoFrame = CreateFrame("Frame")
function ASPEC_WhoFrame_OnUpdate(self, elapsed)
    self.timer = self.timer - elapsed
    if self.timer < 0 then
        ASPEC_QueryWho(ASPEC_Subscribe_Target)
        self.timer = 10
    end
end

function ASPEC_WhoFrame_OnEvent(self, event, ...)
    zone = GetRealZoneText()
    if not ASPEC_IsArenaZone(zone) and ASPEC_TemporaryUnsubscribed then
        StaticPopupDialogs["ARENASPECTATOR_ON_LEAVE_WITH_SUBSCRIBED"] = {
            text = "Would you like to resubscribe to " .. ASPEC_Subscribe_Target .. "?",
            button1 = "Yes",
            button2 = "No",
            OnAccept = function()
                ASPEC_SubscribeTo(ASPEC_Subscribe_Target)
            end,
            OnCancel = function()
                ASPEC_UnsubscribeFull()
            end,
            whileDead = true,
            timeout = 0,
            hideOnEscape = false,
            preferredIndex = 3,
        }
        
        StaticPopup_Show("ARENASPECTATOR_ON_LEAVE_WITH_SUBSCRIBED")
    end
end
ASPEC_WhoFrame:SetScript("OnEvent", ASPEC_WhoFrame_OnEvent)
ASPEC_WhoFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")

function ASPEC_SubscribeTo(name)
    ASPEC_Subscribe_Target = name
    ASPEC_WhoFrame.timer = 1
    ASPEC_WhoFrame:SetScript("OnUpdate", ASPEC_WhoFrame_OnUpdate)
end

function ASPEC_try_SubscribeTo(self, name, unit, server)
    ASPEC_SubscribeTo(name)
end

function ASPEC_UnsubscribeTmp()
    ASPEC_WhoFrame:SetScript("OnUpdate", nil)
    ASPEC_TemporaryUnsubscribed = true
end

function ASPEC_UnsubscribeFull()
    ASPEC_WhoFrame:SetScript("OnUpdate", nil)
    ASPEC_TemporaryUnsubscribed = false
end

-- Command handlers
function SlashCmdList.TEAMNAME_ONE(msg, editbox)
    teamname[0] = msg
    DEFAULT_CHAT_FRAME:AddMessage("Set team 1's name to " .. msg)
    updateScoreBoardFrame()
end

function SlashCmdList.TEAMNAME_TWO(msg, editbox)
    teamname[1] = msg
    DEFAULT_CHAT_FRAME:AddMessage("Set team 2's name to " .. msg)
    updateScoreBoardFrame()
end

function SlashCmdList.TEAMSWITCH(msg, editbox)
    local temp = teamname[0]
    local tempS = teamscore[0]
    teamname[0] = teamname[1]
    teamscore[0] = teamscore[1]
    teamname[1] = temp
    teamscore[1] = tempS
    DEFAULT_CHAT_FRAME:AddMessage("Swapped the teams.")
    updateScoreBoardFrame()
end


function SlashCmdList.UPDATE_SCORE(msg, editbox)
    local team, score = msg:match("^(%S*)%s*(.-)$");
    if tonumber(team) ~= nil and (tonumber(team) == 1 or tonumber(team) == 2) then
        if tonumber(score) ~= nil then
            teamscore[team - 1] = score
            DEFAULT_CHAT_FRAME:AddMessage("Updated score of team " .. teamname[team - 1] .. " to " .. score .. ".")
            updateScoreBoardFrame()
        else
            DEFAULT_CHAT_FRAME:AddMessage("Incorrect score specified.")
        end
    else
        DEFAULT_CHAT_FRAME:AddMessage("Invalid team specified.")
    end
end

function SlashCmdList.RESET_SCORE(msg, editbox)
    teamscore = {0, 0}
    DEFAULT_CHAT_FRAME:AddMessage("The scores were reset.")
    updateScoreBoardFrame()
end

function SlashCmdList.TOURNAMENT(msg, editbox)
    if msg == "on" or msg == "1" then
        tournamentMode = true
        DEFAULT_CHAT_FRAME:AddMessage("Enabled tournament mode.")
        scoreFrame:Show()
    else
        tournamentMode = false
        DEFAULT_CHAT_FRAME:AddMessage("Disabled tournament mode.")
        scoreFrame:Hide()
    end
end

function SlashCmdList.DEBUG(msg, editbox)
    if msg == "on" or msg == "1" then
        debugMode = true
        DEFAULT_CHAT_FRAME:AddMessage("Enabled debug mode.")
    else
        debugMode = false
        DEFAULT_CHAT_FRAME:AddMessage("Disabled debug mode.")
    end
end

function updateTeamOneScore(self, button)
    if button == "LeftButton" then
        teamscore[0] = teamscore[0] + 1
    end
    if button == "RightButton" then
        teamscore[0] = teamscore[0] - 1
    end
    if button == "MiddleButton" then
        teamscore[0] = 0
    end
    updateScoreBoardFrame()
end

function updateTeamTwoScore(self, button)
    if button == "LeftButton" then
        teamscore[1] = teamscore[1] + 1
    end
    if button == "RightButton" then
        teamscore[1] = teamscore[1] - 1
    end
    if button == "MiddleButton" then
        teamscore[1] = 0
    end
    updateScoreBoardFrame()
end

function setupScoreboardFrame()
    -- Create ScoreBoard frame
    scoreFrame = CreateFrame("frame", nil, WorldFrame)
    scoreFrame:SetHeight(34)
    scoreFrame:SetWidth(650)
    scoreFrame:SetPoint("TOP", 0, 0)

    scoreFrame:Hide()

    -- Create team one score box
    teamOneScoreBox = CreateFrame("Button", nil, scoreFrame)
    teamOneScoreBox:SetHeight(30)
    teamOneScoreBox:SetWidth(30)
    teamOneScoreBox:SetPoint("LEFT", 2, 0)

    teamOneScoreBox.texture = teamOneScoreBox:CreateTexture()
    teamOneScoreBox.texture:SetAllPoints(teamOneScoreBox)
    teamOneScoreBox.texture:SetTexture(.8, .2, .2)

    teamOneScoreBox.text = teamOneScoreBox:CreateFontString()
    teamOneScoreBox.text:SetFont(STANDARD_TEXT_FONT, 16, "OUTLINE")
    teamOneScoreBox.text:SetPoint("CENTER", 0, 0)
    teamOneScoreBox.text:SetText(teamscore[0])

    teamOneScoreBox:RegisterForClicks("AnyDown")
    teamOneScoreBox:SetScript("OnClick", updateTeamOneScore)


    -- Create team one name box
    teamOneNameBox = CreateFrame("StatusBar", nil, scoreFrame)
    teamOneNameBox:SetHeight(30)
    teamOneNameBox:SetWidth(200)
    teamOneNameBox:SetPoint("LEFT", 34, 0)

    local tonbtext = teamOneNameBox:CreateTexture(nil, "ARTWORK", nil, 7)
    tonbtext:SetAllPoints(teamOneNameBox)
    tonbtext:SetTexture(BAR_TEXTURE)
    teamOneNameBox:SetStatusBarTexture(tonbtext)
    teamOneNameBox:SetStatusBarColor(.8, .2, .2)
    teamOneNameBox:GetStatusBarTexture():SetHorizTile(false)
    teamOneNameBox:GetStatusBarTexture():SetVertTile(false)

    teamOneNameBox.text = teamOneNameBox:CreateFontString()
    teamOneNameBox.text:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
    teamOneNameBox.text:SetPoint("LEFT", 4, 0)
    teamOneNameBox.text:SetText(teamname[0])

    -- teamOneNameBox:SetMinMaxValues(0, 1)
    -- teamOneNameBox:SetValue(.5)


    -- Create team two score box
    teamTwoScoreBox = CreateFrame("Button", nil, scoreFrame)
    teamTwoScoreBox:SetHeight(30)
    teamTwoScoreBox:SetWidth(30)
    teamTwoScoreBox:SetPoint("RIGHT", -2, 0)

    teamTwoScoreBox.texture = teamTwoScoreBox:CreateTexture()
    teamTwoScoreBox.texture:SetAllPoints(teamTwoScoreBox)
    teamTwoScoreBox.texture:SetTexture(.27, .51, .7)

    teamTwoScoreBox.text = teamTwoScoreBox:CreateFontString()
    teamTwoScoreBox.text:SetFont(STANDARD_TEXT_FONT, 16, "OUTLINE")
    teamTwoScoreBox.text:SetPoint("CENTER", 0, 0)
    teamTwoScoreBox.text:SetText(teamscore[1])

    teamTwoScoreBox:RegisterForClicks("AnyDown")
    teamTwoScoreBox:SetScript("OnClick", updateTeamTwoScore)


    -- Create team two name box
    teamTwoNameBox = CreateFrame("StatusBar", nil, scoreFrame)
    teamTwoNameBox:SetHeight(30)
    teamTwoNameBox:SetWidth(200)
    teamTwoNameBox:SetPoint("RIGHT", -34, 0)

    local ttnbtext = teamTwoNameBox:CreateTexture(nil, "ARTWORK", nil, 7)
    ttnbtext:SetAllPoints(teamTwoNameBox)
    ttnbtext:SetTexture(BAR_TEXTURE)
    teamTwoNameBox:SetStatusBarTexture(ttnbtext)
    teamTwoNameBox:SetStatusBarColor(.27, .51, .7)
    teamTwoNameBox:GetStatusBarTexture():SetHorizTile(false)
    teamTwoNameBox:GetStatusBarTexture():SetVertTile(false)

    teamTwoNameBox.text = teamTwoNameBox:CreateFontString()
    teamTwoNameBox.text:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
    teamTwoNameBox.text:SetPoint("RIGHT", -4, 0)
    teamTwoNameBox.text:SetText(teamname[1])
end

function updateScoreBoardFrame()
    teamOneNameBox.text:SetText(teamname[0])
    teamOneScoreBox.text:SetText(teamscore[0])

    teamTwoNameBox.text:SetText(teamname[1])
    teamTwoScoreBox.text:SetText(teamscore[1])
end

-- Addon setup function
local function init()
    Reset()

    -- Create event handling frame
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("CHAT_MSG_ADDON")
    frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    frame:RegisterEvent("PLAYER_LOGIN")
    frame:RegisterEvent("ADDON_LOADED")
    frame:SetScript("OnEvent", EventHandler)
    frame:SetScript("OnUpdate", CheckUIVisibility)

    -- Castbar update frame
    CreateFrame("Frame"):SetScript("OnUpdate", UpdateCastBar)

    -- Create show/hide button
    toggle = CreateFrame("Button", nil, WorldFrame)
    toggle:SetHeight(20)
    toggle:SetWidth(130)
    toggle:SetPoint("TOPLEFT", 0, 0)
    toggle.texture = toggle:CreateTexture()
    toggle.texture:SetAllPoints(toggle)
    toggle.texture:SetTexture(0.6, 0.6, 0.2)
    toggle:SetScript("OnClick", ToggleUI)
    toggle.text = toggle:CreateFontString()
    toggle.text:SetFont(STANDARD_TEXT_FONT, 16, "OUTLINE")
    toggle.text:SetPoint("CENTER", 0, 0)
    toggle.text:SetText(TEXT.TOGGLEUI)

    setupScoreboardFrame()

    -- Add spectate option to dropdowns
    ASPEC_addDropDownMenuButton("ASPEC_DDMENU_1", "PLAYER", 1, "|cff00ffffSpectate|r", true, ASPEC_try_spectate, "Spectate")
    ASPEC_addDropDownMenuButton("ASPEC_DDMENU_2", "PLAYER", 2, "|cff00ffffSubscribe|r", true, ASPEC_try_SubscribeTo, "Subscribe")
    ASPEC_addDropDownMenuButton("ASPEC_DDMENU_1", "FRIEND", 1, "|cff00ffffSpectate|r", true, ASPEC_try_spectate, "Spectate")
    ASPEC_addDropDownMenuButton("ASPEC_DDMENU_2", "FRIEND", 2, "|cff00ffffSubscribe|r", true, ASPEC_try_SubscribeTo, "Subscribe")

    DEFAULT_CHAT_FRAME:AddMessage("Loaded Sunwell Arena Spectator UI")
end

-- Call addon setup
init()