local CREATURE_EVENT_ON_QUEST_ACCEPT = 31
local CREATURE_EVENT_ON_DIE = 4
local QUEST_ID = 30018
local CREATURE_SPAWNER = 400096
local BUNNY_ENTRY = 400099
local UNDEAD_BUNNY_ENTRY = 400100
local UNDEAD_WARLORD = 400103
local SPAWN_TYPE = 3
local DESPAWN_TIMER = 200000 -- 3 minutes and 20 seconds in milliseconds
local CAST_SPELL_ID = 67040 
local CAST_SPELL_ID2 = 32826

local function CastSpellWithDelay(event, delay, calls, creature)
    creature:CastSpell(creature, CAST_SPELL_ID, false)
end

local function CastSpellPolyVis(event, delay, calls, creature)
    creature:CastSpell(creature, CAST_SPELL_ID2, false)
end

local function OnQuestAccept(event, player, creature, quest)
    if quest:GetId() == QUEST_ID then
		creature:PerformEmote(1)
        creature:SetReactState(0) 
		creature:RegisterEvent(CastSpellPolyVis, 17000, 1)
        creature:RegisterEvent(CastSpellWithDelay, 18200, 1) -- 10-second delay before casting the spell
        local x, y, z, o = creature:GetLocation()
        for i = 1, 5 do
            local randomX = x + math.random(-4, 4)
            local randomY = y + math.random(-4, 4)
            creature:SpawnCreature(BUNNY_ENTRY, randomX, randomY, z, o, SPAWN_TYPE, DESPAWN_TIMER)
        end
        local undeadX = x + math.random(-4, 4)
        local undeadY = y + math.random(-4, 4)
        creature:SpawnCreature(UNDEAD_BUNNY_ENTRY, undeadX, undeadY, z, o, SPAWN_TYPE, DESPAWN_TIMER)
    end
end

local function OnCreatureDeath(event, creature, killer)
    if creature:GetEntry() == UNDEAD_WARLORD then
        local spawner = creature:GetNearestCreature(CREATURE_SPAWNER, 100)
        if spawner then
            spawner:SetReactState(1) -- Set react state back to aggressive
            spawner:StopSpellCast(CAST_SPELL_ID)
        end
    end
end

local function OnSpawnerDeath(event, creature, killer)
    if creature:GetEntry() == CREATURE_SPAWNER then
        local players = creature:GetPlayersInRange(100)
        for _, player in ipairs(players) do
            if player:HasQuest(QUEST_ID) then
                player:FailQuest(QUEST_ID)
            end
        end
    end
end


RegisterCreatureEvent(CREATURE_SPAWNER, CREATURE_EVENT_ON_QUEST_ACCEPT, OnQuestAccept)
RegisterCreatureEvent(UNDEAD_WARLORD, CREATURE_EVENT_ON_DIE, OnCreatureDeath)
RegisterCreatureEvent(CREATURE_SPAWNER, CREATURE_EVENT_ON_DIE, OnSpawnerDeath)
