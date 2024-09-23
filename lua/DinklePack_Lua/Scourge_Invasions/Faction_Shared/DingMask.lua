local DingMasker = {}

DingMasker.npcGroups = {
    [1] = {spellId = 28234, npcIdstwatsls = {8541, 10417, 4475, 11873, 8531, 11551, 10488, 10487, 1788, 10414, 10407, 400010, 400015, 400016, 300018, 16383, 16394, 400036, 400049, 400048, 16437, 16438, 400112}},
    [2] = {spellId = 100133, npcIdstwatsls = {400013, 400014, 68, 1976, 466, 400018, 400019, 400026, 400027, 400033, 400070, 400065, 400042, 400043}},
    [3] = {spellId = 51908, npcIdstwatsls = {400053, 400069, 400055, 400052, 400047, 400056, 400032, 400029, 400073, 400072, 400102, 400103, 16422, 16423, 400011, 400057}}
}

function DingMasker.CastSpellOnSpawn(event, creature)
    if not creature then
        print("Error: creature was not set!")
        return
    end

    local npcId = creature:GetEntry()
    for _, group in pairs(DingMasker.npcGroups) do
        for _, id in ipairs(group.npcIdstwatsls) do
            if id == npcId then
                creature:CastSpell(creature, group.spellId, true)
                return
            end
        end
    end
end

-- Register the event for all NPCs
for _, group in pairs(DingMasker.npcGroups) do
    for _, npcId in ipairs(group.npcIdstwatsls) do
        RegisterCreatureEvent(npcId, 5, DingMasker.CastSpellOnSpawn)
    end
end
