--[[

--Needs lots and lots of work. 

local NPC_ABOMINABLE_GREENCH = 13602 -- Replace this with the correct entry ID for Abominable Greench

local PHASE_ONE = 1
local PHASE_TWO = 2
local PHASE_THREE = 3
local PHASE_FOUR = 4

PHASE_DIALOGUE = {
	[PHASE_ONE] = "",
    [PHASE_TWO] = "You've been naughty! Time for a frosty surprise!",
    [PHASE_THREE] = "Frostbite's nipping at your noses!",
    [PHASE_FOUR] = "I'm the Grinch who stole Winter Veil! Taste my icy wrath!",
}

SPAWN_DIALOGUE = "The Abominable Greench has come to ruin your Winter Veil! Bwahaha!"
DEATH_DIALOGUE = "Winter...veil...will...return..."
AGGRO_DIALOGUE = "You're a mean one, aren't you? Time to crush your holiday spirit!"

local SPELL_FROSTBOLT = 10179
local SPELL_CONE_OF_COLD = 20828
local SPELL_FROST_NOVA = 27088
local SPELL_BLIZZARD = 19099
local SPELL_ICE_ARMOR = 12544
local SPELL_ICY_VEINS = 12472
local SPELL_SUMMON_WINTER_WISP = 39319 -- Replace with a custom spell that summons Winter Wisp adds

local phaseAbilities = {
    [PHASE_ONE] = {
        {spell = SPELL_FROSTBOLT, minInterval = 3000, maxInterval = 6000},
        {spell = SPELL_CONE_OF_COLD, minInterval = 10000, maxInterval = 15000},
    },
    [PHASE_TWO] = {
        {spell = SPELL_FROST_NOVA, minInterval = 12000, maxInterval = 18000},
        {spell = SPELL_BLIZZARD, minInterval = 20000, maxInterval = 25000},
    },
    [PHASE_THREE] = {
        {spell = SPELL_ICY_VEINS, minInterval = 60000, maxInterval = 90000},
        {spell = SPELL_SUMMON_WINTER_WISP, minInterval = 30000, maxInterval = 45000},
    },
}

local function GetPhaseByHealth(healthPct)
    if healthPct > 75 then
        return PHASE_ONE
    elseif healthPct > 50 then
        return PHASE_TWO
    elseif healthPct > 25 then
        return PHASE_THREE
    else
        return PHASE_FOUR
    end
end


local function CastSpellWithCooldown(eventId, delay, repeats, creature, spell, minInterval, maxInterval, triggered)
    if creature:IsInCombat() then
        creature:CastSpell(creature:GetVictim(), spell, triggered)
        local interval = math.random(minInterval, maxInterval)
        creature:RegisterEvent(CastSpellWithCooldown, interval, 1, creature, spell, minInterval, maxInterval, triggered)
    end
end


local function ApplyPhaseAbilities(creature, phase)
    creature:RemoveEvents()
    for _, ability in ipairs(phaseAbilities[phase]) do
        local triggered = ability.spell == SPELL_CONE_OF_COLD
        CastSpellWithCooldown(creature, ability.spell, ability.minInterval, ability.maxInterval, triggered)
    end
end

local function Greench_OnEnterCombat(event, creature, target)
    creature:CastSpell(creature, SPELL_ICE_ARMOR, true)
    local currentPhase = GetPhaseByHealth(creature:GetHealthPct())

    creature:SendUnitYell(AGGRO_DIALOGUE, 0)
    ApplyPhaseAbilities(creature, currentPhase)
end

local function Greench_OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function Greench_OnDamageTaken(event, creature, attacker, damage)
    local healthPct = creature:GetHealthPct()
    local newPhase = GetPhaseByHealth(healthPct)

    if newPhase ~= creature:GetData("currentPhase") then
        creature:RemoveEvents()
        creature:SetData("currentPhase", newPhase)
        if PHASE_DIALOGUE[newPhase] then
            creature:SendUnitYell(PHASE_DIALOGUE[newPhase], 0)
        end
        ApplyPhaseAbilities(creature, newPhase)
    end
end


local function Greench_OnDied(event, creature, killer)
    creature:RemoveEvents()
    creature:SendUnitYell(DEATH_DIALOGUE, 0)
end

local function Greench_OnSpawn(event, creature)
    creature:SetData("currentPhase", PHASE_ONE)
    creature:SendUnitYell(SPAWN_DIALOGUE, 0)
end

RegisterCreatureEvent(NPC_ABOMINABLE_GREENCH, 1, Greench_OnEnterCombat)
RegisterCreatureEvent(NPC_ABOMINABLE_GREENCH, 2, Greench_OnLeaveCombat)
RegisterCreatureEvent(NPC_ABOMINABLE_GREENCH, 4, Greench_OnDied)
RegisterCreatureEvent(NPC_ABOMINABLE_GREENCH, 9, Greench_OnDamageTaken)
RegisterCreatureEvent(NPC_ABOMINABLE_GREENCH, 5, Greench_OnSpawn)

]]