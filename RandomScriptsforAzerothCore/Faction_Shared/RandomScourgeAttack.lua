local ENABLED = true -- set to false to disable

local GAME_EVENT_ID = 17 -- Set the game event ID
local MAX_NPC_SPAWN = 3 -- Set the maximum number of NPCs to spawn simultaneously. Extremely high numbers will hurt performance
local ATTACK_CHANCE = 10 -- Set the likelihood of an attack here, in percent
local DAZE_SPELL_ID = 100201 -- Set the spell ID for daze
local MINIMUM_LEVEL = 15 -- Set min level to be active
local EXCLUDED_MAP_ID = 530 

local creatureEntries = {
    16423,
    16422,
    400011,
    400057
} -- Add NPC entries above (CHANGE THESE OR IT WON'T WORK! I'M USING CUSTOM IDs)

local npcdialogue = {
    "Grrrr...",
    "Rrrrr...",
    "Grraaargh...",
    "Raaargh...",
    "Hssss..."
} -- Add dialogue above

local function IsGameEventActive(eventId)
    local activeEvents = GetActiveGameEvents()
    for _, event in ipairs(activeEvents) do
        if event == eventId then
            return true
        end
    end
    return false
end

local function SpawnAttacker(event, player)
    if not ENABLED then 
        return
    end
    if player:GetLevel() < MINIMUM_LEVEL or player:GetMapId() == EXCLUDED_MAP_ID then
        return
    end
    if IsGameEventActive(GAME_EVENT_ID) then
        local chance = math.random(100)

        if chance <= ATTACK_CHANCE then 
            local mapId = player:GetMapId()
            local x, y, z, o = player:GetLocation()
            local level = player:GetLevel()
            local health = player:GetHealth() * 1.65
            local npcCount = math.random(1, MAX_NPC_SPAWN)

            -- Check if the player is mounted and not flying
            if player:IsMounted() and not player:IsFlying() then 
                player:Dismount()
                player:CastSpell(player, DAZE_SPELL_ID, true)
                player:SendBroadcastMessage("You have been knocked off your mount!")
            end

            for i = 1, npcCount do
                local selectedCreature = creatureEntries[math.random(#creatureEntries)]
                local randomX = x + math.random(-18, 18)
                local randomY = y + math.random(-18, 18)
                local spawnedCreature = player:SpawnCreature(selectedCreature, randomX, randomY, z, o, 7, 130000)
                spawnedCreature:SetLevel(level)
                spawnedCreature:SetMaxHealth(health)
                spawnedCreature:SetHealth(health)
                spawnedCreature:AttackStart(player)

                local selectedDialogue = npcdialogue[math.random(#npcdialogue)]
                spawnedCreature:SendUnitYell(selectedDialogue, 0)
            end
        end
    end
end

RegisterPlayerEvent(27, SpawnAttacker)
