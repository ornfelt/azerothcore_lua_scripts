local TotemKills = {}

TotemKills.SEARCH_RANGE = 40
TotemKills.CREATURE_ENTRIES = {4344, 4345}
TotemKills.KILL_CREDIT = 23811
TotemKills.TOTEM_CREATURE = 23811

function TotemKills.OnCreatureDied(event, creature, killer)
    local totemsInRange = creature:GetCreaturesInRange(TotemKills.SEARCH_RANGE, TotemKills.TOTEM_CREATURE)
    
    for _, totem in ipairs(totemsInRange) do
        if creature:GetDistance(totem) <= TotemKills.SEARCH_RANGE then
            local playersInRange = totem:GetPlayersInRange(TotemKills.SEARCH_RANGE, 0, 1)
            
            for _, player in ipairs(playersInRange) do
                local owner = totem:GetOwner()
                if owner and owner:GetGUID() == player:GetGUID() then
                    player:KilledMonsterCredit(TotemKills.KILL_CREDIT)
                end
            end
        end
    end
end

for _, entry in ipairs(TotemKills.CREATURE_ENTRIES) do
    RegisterCreatureEvent(entry, 4, TotemKills.OnCreatureDied)
end
