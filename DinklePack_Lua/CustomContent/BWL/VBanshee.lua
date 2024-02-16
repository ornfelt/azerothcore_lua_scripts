local VBanshee = {}

local function CastSilence(eventId, delay, calls, creature)
    local targets = creature:GetAITargets()
    if #targets > 0 then
        local target = targets[math.random(1, #targets)]
        creature:CastSpell(target, 65542, true)
    end
end

local function CastShadowBolt(eventId, delay, calls, creature)
    local targets = creature:GetAITargets()
    if #targets > 0 then
        local target = targets[math.random(1, #targets)]
        creature:CastSpell(target, 11660, false)
    end
end

local function OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CastSilence, 8000, 0)
    creature:RegisterEvent(CastShadowBolt, 5000, 0)
end

local function OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
    creature:DespawnOrUnsummon(5000)
    creature:RemoveEvents()
end

local function OnSpawn(event, creature)
    creature:CastSpell(creature, 51908, true)
end

VBanshee.OnEnterCombat = OnEnterCombat
VBanshee.OnLeaveCombat = OnLeaveCombat
VBanshee.OnDied = OnDied
VBanshee.OnSpawn = OnSpawn

RegisterCreatureEvent(400152, 1, VBanshee.OnEnterCombat)
RegisterCreatureEvent(400152, 2, VBanshee.OnLeaveCombat)
RegisterCreatureEvent(400152, 4, VBanshee.OnDied)
RegisterCreatureEvent(400152, 5, VBanshee.OnSpawn)
