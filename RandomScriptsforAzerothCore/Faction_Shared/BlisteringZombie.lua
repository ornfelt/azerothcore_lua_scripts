local BlisteringZombie = {};

local function CastArmyOfTheDead(eventId, delay, calls, creature)
    creature:CastSpell(creature, 42650, true)
end

local function CastSpit(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 25262, true)
end

local function CastSpecialSpell(eventId, delay, calls, creature)
    local victim = creature:GetVictim()
    if not victim then
        return
    end
    if victim:GetEntry() == 32666 or victim:GetEntry() == 32667 or victim:GetEntry() == 31144 or victim:GetEntry() == 31146 then
        creature:CastSpell(victim, 5, true)
    end
end

local function OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CastArmyOfTheDead, 25000, 0)
    creature:RegisterEvent(CastSpit, 5000, 0)
    creature:RegisterEvent(CastSpecialSpell, 1000, 0)
end

local function OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function OnSpawn(event, creature)
    creature:RegisterEvent(CastArmyOfTheDead, 1000, 1)
end

local function OnDied(event, creature, killer)
    creature:DespawnOrUnsummon(5000)
    creature:RemoveEvents()
end


RegisterCreatureEvent(400029, 1, OnEnterCombat)
RegisterCreatureEvent(400029, 2, OnLeaveCombat)
RegisterCreatureEvent(400029, 4, OnDied)
RegisterCreatureEvent(400029, 5, OnSpawn)

