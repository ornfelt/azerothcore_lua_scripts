local ValkyrProtector = {}

ValkyrProtector.NPC_ID = 401119
ValkyrProtector.SPELL_IDS = {
    FLASH_HEAL = 10916,
    SMITE = 10933
}
ValkyrProtector.HEALTH_PERCENT_THRESHOLD = 90
ValkyrProtector.SEARCH_RANGE = 40
ValkyrProtector.MIN_CREATURE_ENTRY = 70000
ValkyrProtector.MAX_CREATURE_ENTRY = 81000

function ValkyrProtector.FindLowHealthUnit(creature)
    local lowHealthUnit = nil
    local minHealthPercent = ValkyrProtector.HEALTH_PERCENT_THRESHOLD

    for _, unit in ipairs(creature:GetFriendlyUnitsInRange(ValkyrProtector.SEARCH_RANGE)) do
        local unitEntry = unit:GetEntry()
        local isPlayer = unit:IsPlayer()
        local isCreatureInRange = (unitEntry >= ValkyrProtector.MIN_CREATURE_ENTRY) and (unitEntry <= ValkyrProtector.MAX_CREATURE_ENTRY)
        if isPlayer or isCreatureInRange then
            local healthPercent = (unit:GetHealth() / unit:GetMaxHealth()) * 100
            if healthPercent < minHealthPercent then
                minHealthPercent = healthPercent
                lowHealthUnit = unit
            end
        end
    end

    return lowHealthUnit
end

function ValkyrProtector.CastFlashHealOnLowHealthUnit(eventId, delay, repeats, creature)
    local lowHealthUnit = ValkyrProtector.FindLowHealthUnit(creature)

    if lowHealthUnit then
        creature:CastSpell(lowHealthUnit, ValkyrProtector.SPELL_IDS.FLASH_HEAL, false)
    end
end

function ValkyrProtector.CastSmiteOnVictim(eventId, delay, repeats, creature)
    local victim = creature:GetVictim()

    if victim then
        creature:CastSpell(victim, ValkyrProtector.SPELL_IDS.SMITE, false)
    end
end

function ValkyrProtector.OnEnterCombat(event, creature)
    creature:RegisterEvent(ValkyrProtector.CastFlashHealOnLowHealthUnit, 6000, 0)
    creature:RegisterEvent(ValkyrProtector.CastSmiteOnVictim, 5000, 0)
end

function ValkyrProtector.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function ValkyrProtector.OnCreatureDeath(event, creature)
    creature:RemoveEvents()
end

-- Register the event handlers for Val'kyr Protector
RegisterCreatureEvent(ValkyrProtector.NPC_ID, 1, ValkyrProtector.OnEnterCombat)
RegisterCreatureEvent(ValkyrProtector.NPC_ID, 2, ValkyrProtector.OnLeaveCombat)
RegisterCreatureEvent(ValkyrProtector.NPC_ID, 4, ValkyrProtector.OnCreatureDeath)
