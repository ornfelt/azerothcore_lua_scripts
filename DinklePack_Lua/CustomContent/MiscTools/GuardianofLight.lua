local ValkGuard = {}

ValkGuard["NPC_ID"] = 600018
ValkGuard["SPELL_FLASH_OF_LIGHT"] = 19942
ValkGuard["HAMMER_OF_WRATH"] = 24275
ValkGuard["HOLY_NOVA"] = 27799
ValkGuard["AVENGING_WRATH"] = 31884
ValkGuard["HEALTH_PERCENT_THRESHOLD"] = 90
ValkGuard["SEARCH_RANGE"] = 40
ValkGuard["MIN_CREATURE_ENTRY"] = 70000
ValkGuard["MAX_CREATURE_ENTRY"] = 81000

local function FindLowHealthUnit(creature)
    local lowHealthUnit = nil
    local minHealthPercent = ValkGuard["HEALTH_PERCENT_THRESHOLD"]

    for _, unit in ipairs(creature:GetFriendlyUnitsInRange(ValkGuard["SEARCH_RANGE"])) do
        local unitEntry = unit:GetEntry()
        local isPlayer = unit:IsPlayer()
        local isCreatureInRange = (unitEntry >= ValkGuard["MIN_CREATURE_ENTRY"]) and (unitEntry <= ValkGuard["MAX_CREATURE_ENTRY"])
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

local function CastFOLowHealthUnit(eventId, delay, repeats, creature)
    local lowHealthUnit = FindLowHealthUnit(creature)

    if lowHealthUnit then
        creature:CastSpell(lowHealthUnit, ValkGuard["SPELL_FLASH_OF_LIGHT"], true)
    end
end

local function CastHammerVictim(eventId, delay, repeats, creature)
    local victim = creature:GetVictim()

    if victim then
        creature:CastSpell(victim, ValkGuard["HAMMER_OF_WRATH"], true)
    end
end

local function CastHolyNova(eventId, delay, repeats, creature)
    creature:CastSpell(creature, ValkGuard["HOLY_NOVA"], true)
end

local function OnSpawn(event, creature)
    local owner = creature:GetOwner()
    if owner then
        owner:AddAura(ValkGuard["AVENGING_WRATH"], owner)
    end
end

local function OnEnterCombat(event, creature)
    creature:RegisterEvent(CastFOLowHealthUnit, math.random(3000, 7000), 0)
    creature:RegisterEvent(CastHammerVictim, math.random(4000, 7000), 0)
    creature:RegisterEvent(CastHolyNova, math.random(4000, 9000), 0)
end

local function OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function OnCreatureDeath(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(ValkGuard["NPC_ID"], 1, OnEnterCombat)
RegisterCreatureEvent(ValkGuard["NPC_ID"], 2, OnLeaveCombat)
RegisterCreatureEvent(ValkGuard["NPC_ID"], 4, OnCreatureDeath)
RegisterCreatureEvent(ValkGuard["NPC_ID"], 5, OnSpawn)
