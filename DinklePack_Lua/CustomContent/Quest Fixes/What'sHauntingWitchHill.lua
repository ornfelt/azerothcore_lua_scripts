local RestlessSpiritsWhWh = {}

RestlessSpiritsWhWh.NPC_IDS = {
    RISEN_SPIRITS_ID = 23554,
    RISEN_HUSKS_ID = 23555,
    RESTLESS_SPIRITS_ID = 23861
}

RestlessSpiritsWhWh.DESPAWN_TIME = 8000
RestlessSpiritsWhWh.RANGE_TO_GIVE_CREDIT = 30

function RestlessSpiritsWhWh.GiveKillCredit(eventId, delay, repeats, player)
    if player then
        player:KilledMonsterCredit(RestlessSpiritsWhWh.NPC_IDS.RESTLESS_SPIRITS_ID)
    end
end

function RestlessSpiritsWhWh.SpawnRestlessSpirit(event, creature, killer)
    if creature:GetEntry() == RestlessSpiritsWhWh.NPC_IDS.RISEN_SPIRITS_ID or creature:GetEntry() == RestlessSpiritsWhWh.NPC_IDS.RISEN_HUSKS_ID then
        local x, y, z, o = creature:GetLocation()
        local spawnedCreature = creature:SpawnCreature(RestlessSpiritsWhWh.NPC_IDS.RESTLESS_SPIRITS_ID, x, y, z, o, 3, RestlessSpiritsWhWh.DESPAWN_TIME)

        if spawnedCreature then
            local playersInRange = creature:GetPlayersInRange(RestlessSpiritsWhWh.RANGE_TO_GIVE_CREDIT)

            for _, player in pairs(playersInRange) do
                if player:IsPlayer() then
                    player:RegisterEvent(RestlessSpiritsWhWh.GiveKillCredit, 2000, 1)
                end
            end
        end
    end
end

RegisterCreatureEvent(RestlessSpiritsWhWh.NPC_IDS.RISEN_SPIRITS_ID, 4, RestlessSpiritsWhWh.SpawnRestlessSpirit)
RegisterCreatureEvent(RestlessSpiritsWhWh.NPC_IDS.RISEN_HUSKS_ID, 4, RestlessSpiritsWhWh.SpawnRestlessSpirit)
