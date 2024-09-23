local BarrelQuest = {}

BarrelQuest.SPELL_ID = 80106
BarrelQuest.QUEST_ID = 30036
BarrelQuest.CREATURE_ID = 29692
BarrelQuest.SPAWN_POSITION = {-8936, 635, 98.88, 0}  
BarrelQuest.SPAWN_DELAY = 6000  
BarrelQuest.DESPAWN_DELAY = 20 * 1000 

function BarrelQuest.OnSpellCast(event, player, spell, skipCheck)
    if spell:GetEntry() == BarrelQuest.SPELL_ID then
        local playerPos = {player:GetX(), player:GetY(), player:GetZ()}
        local distance = math.sqrt((playerPos[1] - BarrelQuest.SPAWN_POSITION[1])^2 + (playerPos[2] - BarrelQuest.SPAWN_POSITION[2])^2 + (playerPos[3] - BarrelQuest.SPAWN_POSITION[3])^2)

        if distance <= 5 then
            player:CompleteQuest(BarrelQuest.QUEST_ID)
                local function SpawnAndDespawnCreature(eventId, delay, repeats, worldobject)
                local spawnedCreature = worldobject:SpawnCreature(BarrelQuest.CREATURE_ID, BarrelQuest.SPAWN_POSITION[1], BarrelQuest.SPAWN_POSITION[2], BarrelQuest.SPAWN_POSITION[3], BarrelQuest.SPAWN_POSITION[4], 3, BarrelQuest.DESPAWN_DELAY)
            end
            player:RegisterEvent(SpawnAndDespawnCreature, BarrelQuest.SPAWN_DELAY, 1)  
        else
            spell:Cancel()
            player:SendBroadcastMessage("You need to be closer to the ladder to use that item.")
        end
    end
end

RegisterPlayerEvent(5, BarrelQuest.OnSpellCast)
