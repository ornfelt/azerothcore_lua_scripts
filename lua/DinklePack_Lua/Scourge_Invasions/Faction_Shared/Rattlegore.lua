local Rattlegore = {}

Rattlegore.npcId = 11622

local function Thunderclap(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 26554, true)
end

local function WhirlwindKnockback(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 34109, true)
end

local function Enrage(eventId, delay, calls, creature)
    creature:CastSpell(creature, 15716, true)
end

local function BoneArmor(eventId, delay, calls, creature)
    creature:CastSpell(creature, 38882, true)
end

local function Thrash(eventId, delay, calls, creature)
    creature:CastSpell(creature, 3391, true)
end

local function SweepingStrikes(eventId, delay, calls, creature)
    creature:CastSpell(creature, 18765, true)
end

local function Stun(eventId, delay, calls, creature)
    local targets = creature:GetAITargets(10)
    if #targets == 0 then
        return
    end
    local target = targets[math.random(#targets)]
    creature:CastSpell(target, 17308, true)
end

function Rattlegore.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(Thunderclap, math.random(5000, 9000), 0)
    creature:RegisterEvent(WhirlwindKnockback, math.random(11000, 15000), 0)
    creature:RegisterEvent(Stun, math.random(14000, 18000), 0)
    creature:RegisterEvent(Thrash, math.random(6000, 10000), 0)
    creature:RegisterEvent(BoneArmor, math.random(12000, 18000), 0)
    creature:RegisterEvent(BoneArmor, 500, 1)
    creature:RegisterEvent(SweepingStrikes, 100, 1)
end

function Rattlegore.OnHealthUpdate(event, creature, value)
    if (creature:GetHealthPct() <= 20) then
        creature:RemoveEvents()
        creature:RegisterEvent(Enrage, 100, 1)
    end
end

function Rattlegore.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function Rattlegore.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(Rattlegore.npcId, 1, Rattlegore.OnEnterCombat)
RegisterCreatureEvent(Rattlegore.npcId, 9, Rattlegore.OnHealthUpdate)
RegisterCreatureEvent(Rattlegore.npcId, 2, Rattlegore.OnLeaveCombat)
RegisterCreatureEvent(Rattlegore.npcId, 4, Rattlegore.OnDied)
