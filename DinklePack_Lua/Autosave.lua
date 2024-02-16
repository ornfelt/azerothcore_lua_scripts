--[[local AttackerSpawnModule = {}

AttackerSpawnModule.ITEM_ID = 800050 
AttackerSpawnModule.MAX_NPC_SPAWN = 3 
AttackerSpawnModule.ATTACK_CHANCE = 15
AttackerSpawnModule.DAZE_SPELL_ID = 100201 

AttackerSpawnModule.creatureEntriesByLevelBracket = {
    [1] = {38},
    [11] = {16303},
    [21] = {485},
    [31] = {4147}, 
    [41] = {5255}, 
    [51] = {6513}, 
    [61] = {16951}, 
    [71] = {26948}, 
}

AttackerSpawnModule.extraCreatureEntriesByLevelBracket = {
    [1] = {99},
    [11] = {11519},
    [21] = {4829},
    [31] = {7345}, 
    [41] = {5256}, 
    [51] = {10317}, 
    [61] = {19997}, 
    [71] = {28793}, 
}

function AttackerSpawnModule.HasRequiredItem(player)
    return player:HasItem(AttackerSpawnModule.ITEM_ID)
end

function AttackerSpawnModule.GetCreatureEntriesForLevel(level)
    local sortedBrackets = {}
    for bracket, _ in pairs(AttackerSpawnModule.creatureEntriesByLevelBracket) do
        table.insert(sortedBrackets, bracket)
    end
    table.sort(sortedBrackets, function(a, b) return a > b end)  -- sort in descending order

    for _, bracket in ipairs(sortedBrackets) do
        if level >= bracket then
            return AttackerSpawnModule.creatureEntriesByLevelBracket[bracket]
        end
    end
    return {} 
end

function AttackerSpawnModule.GetRandomPositionWithinLOS(player)
    local x, y, z, o = player:GetLocation()
    local tries = 0
    local max_tries = 20
    local new_x, new_y
    while tries < max_tries do
        new_x = x + math.random(-18, 18)
        new_y = y + math.random(-18, 18)
        if player:IsWithinLoS(new_x, new_y, z) then
            return new_x, new_y
        end
        tries = tries + 1
    end
    return x, y -- if no position found within LOS, return original player position
end

function AttackerSpawnModule.SetCreatureHealthRelativeToPlayer(player, creature)
    local playerHealth = player:GetHealth()
    local newHealth = playerHealth * 0.92
    creature:SetMaxHealth(newHealth)
    creature:SetHealth(newHealth)
end

function AttackerSpawnModule.SpawnAttacker(event, player)
	if player:GetMap():IsBattleground() then
        return
    end
    if not AttackerSpawnModule.HasRequiredItem(player) then
        return
    end
    
    local randomValue = math.random(100)

    if randomValue <= AttackerSpawnModule.ATTACK_CHANCE then 
        local mapId = player:GetMapId()
        local x, y, z, o = player:GetLocation()
        local level = player:GetLevel()
        local npcCount = math.random(1, AttackerSpawnModule.MAX_NPC_SPAWN)
        local creatureEntries = AttackerSpawnModule.GetCreatureEntriesForLevel(level)

        if player:IsMounted() and not player:IsFlying() then
            if randomValue <= 50 then
                player:Dismount()
                player:CastSpell(player, AttackerSpawnModule.DAZE_SPELL_ID, true)
                player:SendBroadcastMessage("You have been knocked off your mount!")
            end
        end

        if not player:IsOnVehicle() then
            if #creatureEntries > 0 then
                for i = 1, npcCount do
                    local selectedCreature = creatureEntries[randomValue % #creatureEntries + 1]
                    local randomX, randomY = AttackerSpawnModule.GetRandomPositionWithinLOS(player)
                    local spawnedCreature = player:SpawnCreature(selectedCreature, randomX, randomY, z, o, 4, 130000)
                    AttackerSpawnModule.SetCreatureHealthRelativeToPlayer(player, spawnedCreature)
                    spawnedCreature:SetLevel(level)
                    spawnedCreature:AttackStart(player)
                    spawnedCreature:DespawnOrUnsummon(180000)
                end

				if randomValue <= 3 then
					local extraCreatureEntries = AttackerSpawnModule.GetCreatureEntriesForLevel(level)
					if extraCreatureEntries and #extraCreatureEntries > 0 then
						local extraCreatureEntry = extraCreatureEntries[randomValue % #extraCreatureEntries + 1]
						local randomX, randomY = AttackerSpawnModule.GetRandomPositionWithinLOS(player)
						local spawnedExtraCreature = player:SpawnCreature(extraCreatureEntry, randomX, randomY, z, o, 4, 180000)
						spawnedExtraCreature:SetLevel(level)
						spawnedExtraCreature:AttackStart(player)
					end
				end

            else
                player:SendBroadcastMessage("No creatures to spawn for your level.")
            end
        end
    end
end

RegisterPlayerEvent(27, AttackerSpawnModule.SpawnAttacker)
]]