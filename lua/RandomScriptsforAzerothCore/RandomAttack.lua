local MAX_NPC_SPAWN = 1 -- Set the maximum number of NPCs to spawn simultaneously. Extremely high numbers will hurt performance
local ATTACK_CHANCE = 10 -- Set the likelihood of an attack here, in percent

local creatureEntries = {
    123,
    456,
    789
} -- Add NPC entries above (CHANGE THESE)

local npcdialogue = {
    "I am dialogue option1",
    "I am dialogue option2",
    "I am dialogue option3",
    "I am dialogue option4",
    "I am dialogue option5"
} -- Add dialogue above

local function SpawnAttacker(event, player)
    local map = player:GetMap()
    if map:IsDungeon() or map:IsRaid() or map:IsBattleground() then
        return
    end

    local chance = math.random(100)

    if chance <= ATTACK_CHANCE then 
        local mapId = player:GetMapId()
        local x, y, z, o = player:GetLocation()
        local level = player:GetLevel()
        local health = player:GetHealth() * 1.65
        local npcCount = MAX_NPC_SPAWN

        for i = 1, npcCount do
            local selectedCreature = creatureEntries[math.random(#creatureEntries)]
            local randomX = x + math.random(-10, 10)
            local randomY = y + math.random(-10, 10)
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

RegisterPlayerEvent(27, SpawnAttacker)
