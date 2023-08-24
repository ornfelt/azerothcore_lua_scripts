------------------------------------------------------------------------------------------------
-- HUNTER START WITH PET MOD
------------------------------------------------------------------------------------------------

local EnableModule   = false   -- Enable module
local AnnounceModule = true   -- Announce module on player login ?

local LoadFromDB     = true   -- true  : Load beasts automatically from the database
                              -- false : Use PET_NPC_DB list below

-- This table is used only when LoadFromDB=false
-- entry,maxLevel
local PET_NPC_DB = {
    {299,1},    -- Diseased Young Wolf
    {705,1},    -- Ragged Young Wolf
    {1508,1},   -- Young Scavenger
    {2031,1},   -- Young Nightsaber
    {3826,1},   -- Rabid Ghostpaw
    {15366,1},  -- Springpaw Cub
    {16520,1},  -- Vale Moth
    {26016,1},  -- Tamable Wolf
    {26017,1},  -- Tamable Bat
    {26019,1},  -- Tamable Carrion Bird
    {26020,1},  -- Tamable Boar
    {26021,1},  -- Tamable Cat
    {26024,1},  -- Tamable Dragonhawk
    {26027,1},  -- Tamable Nether Ray
    {26028,1},  -- Tamable Bird of Prey
    {26029,1},  -- Tamable Raptor
    {26032,1},  -- Tamable Serpent
    {26033,1},  -- Tamable Spider
    {26037,1},  -- Tamable Warp Stalker
    {26038,1},  -- Tamable Wind Serpent
    {34018,1},  -- Tamable Sporebat
    {34019,1},  -- Tamable Hyena
    {34021,1},  -- Tamable Moth
    {34022,1},  -- Tamable Tallstrider
    {34024,1},  -- Tamable Wasp
    {34025,1},  -- Tamable Bear
    {34026,1},  -- Tamable Crab
    {34027,1},  -- Tamable Crocolisk
    {34028,1},  -- Tamable Gorilla
    {34029,1},  -- Tamable Turtle
}

-- spellId
local PET_SPELLS = {
    883,   -- Call Pet
    982,   -- Revive Pet
    1515,  -- Tame Beast
    2641,  -- Dismiss Pet
    6991,  -- Feed Pet
    136    -- Mend Pet (Rank 1)
}

-- Pet happiness values
-- Unhappy =      0 - 333000
-- Content = 333001 - 666000
-- Happy   = 666001 - 1050000
-- Default = 166500 (Unhappy)

local PET_STARTWITH_HAPPINESS = 500000

------------------------------------------------------------------------------------------------
-- END CONFIG
------------------------------------------------------------------------------------------------

if (not EnableModule) then return end
local FILE_NAME        = string.match(debug.getinfo(1,'S').source, "[^/\\]*.lua$")
local CLASS_HUNTER     = 3
local POWER_HAPPINESS  = 4

local function loadPetDB()
    PET_NPC_DB = {}

    local Query
    -- Normal/Elite Tameable beasts (non-exotic, non-rare)
    if(GetCoreName() == "MaNGOS") then
        Query = WorldDBQuery("SELECT Entry, MaxLevel FROM creature_template WHERE CreatureType=1 AND CreatureTypeFlags&1 <> 0 AND Type_Flags&65536 = 0 AND Family!=0 AND rank IN (0,1,5) ORDER BY MaxLevel ASC;")
    elseif(GetCoreName() == "TrinityCore" or GetCoreName() == "AzerothCore") then
        Query = WorldDBQuery("SELECT Entry, MaxLevel FROM creature_template WHERE Type=1 AND Type_Flags&1 <> 0 AND Type_Flags&65536 = 0 AND Family!=0 AND rank IN (0,1,5) ORDER BY MaxLevel ASC;")
    end

    if(Query) then
        repeat
            table.insert(PET_NPC_DB, {Query:GetUInt32(0), Query:GetUInt32(1)})
        until not Query:NextRow()
        PrintInfo("["..FILE_NAME.."][HunterStartWithPet]<loadPetDB()> Loaded "..Query:GetRowCount().." total tameable beasts from database.")
    else
        PrintError("["..FILE_NAME.."][HunterStartWithPet]<loadPetDB()> Could not load tameable beasts from database.")
    end
end

local function onLogin(event, player)
    player:SendBroadcastMessage("This server is running the |cff4CFF00HunterStartWithPet|r module.")
end

local function onFirstLogin(event, player)
    if(player:GetClass() == CLASS_HUNTER) then
        for _,v in ipairs(PET_SPELLS) do
            player:LearnSpell(v)
        end
        local plevel = player:GetLevel()
        local maxidx = 0
        for i,v in ipairs(PET_NPC_DB) do
            if (plevel >= v[2]) then
                maxidx = i
            else
                break
            end
        end
        -- player:SendBroadcastMessage("[|cff4CFF00HunterStartWithPet|r][DEBUG] Beast random pool size for level "..plevel..": "..maxidx)
        local pet = PerformIngameSpawn(1, PET_NPC_DB[math.random(1,maxidx)][1], player:GetMapId(), player:GetInstanceId(), player:GetX()+math.cos(player:GetO()-math.pi/2), player:GetY()+math.sin(player:GetO()-math.pi/2), player:GetZ(), player:GetO(), false, 5000)
        pet:SetFaction(35)
        player:CastSpell(pet, 2650, true)
        local guid = player:GetPetGUID()
        if(guid) then
            player:GetMap():GetWorldObject(guid):ToUnit():SetPower(PET_STARTWITH_HAPPINESS, POWER_HAPPINESS)
        end
    end
end

if (LoadFromDB) then
    loadPetDB()
end

if (#PET_NPC_DB > 0) then
    RegisterPlayerEvent(30, onFirstLogin) -- PLAYER_EVENT_ON_FIRST_LOGIN
    if (AnnounceModule) then
        RegisterPlayerEvent(3, onLogin)   -- PLAYER_EVENT_ON_LOGIN
    end
    PrintInfo("["..FILE_NAME.."][HunterStartWithPet] Module loaded.")
else
    PrintError("["..FILE_NAME.."][HunterStartWithPet] Error loading module, table `PET_NPC_DB` is empty.")
end