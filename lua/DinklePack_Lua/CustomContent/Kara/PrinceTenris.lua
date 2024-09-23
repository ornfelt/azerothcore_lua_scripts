local PrinceTenrisMirkblood = {}

PrinceTenrisMirkblood.NPC_ID = 28194 -- The id of Prince Tenris Mirkblood
PrinceTenrisMirkblood.SPELL_IDS = {
    BLOOD_MIRROR = 70838,
    SUMMON_SANGUINE_SPIRIT = 51280,
    SANGUINE_STRIKE = 51285,
    BLOOD_SWOOP = 50923
}

function PrinceTenrisMirkblood.CastBloodMirror(eventId, delay, calls, creature)
    local raidMembers = creature:GetAITargets(10) -- Get up to 10 raid members
    if #raidMembers > 0 then
        local targetIndex = math.random(1, #raidMembers)
        local randomTarget = raidMembers[targetIndex]
        if randomTarget then
            creature:CastSpell(randomTarget, PrinceTenrisMirkblood.SPELL_IDS.BLOOD_MIRROR)
        end
    end
end

function PrinceTenrisMirkblood.CastSanguineSpirit(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), PrinceTenrisMirkblood.SPELL_IDS.SUMMON_SANGUINE_SPIRIT, true)
end

function PrinceTenrisMirkblood.CastSanguineStrike(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), PrinceTenrisMirkblood.SPELL_IDS.SANGUINE_STRIKE)
end

function PrinceTenrisMirkblood.CastBloodSwoop(eventId, delay, calls, creature)
    local raidMembers = creature:GetAITargets(10) -- Get up to 10 raid members
    if #raidMembers > 0 then
        local targetIndex = math.random(1, #raidMembers)
        local randomTarget = raidMembers[targetIndex]
        if randomTarget then
            creature:CastSpell(randomTarget, PrinceTenrisMirkblood.SPELL_IDS.BLOOD_SWOOP)
        end
    end
end

function PrinceTenrisMirkblood.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(PrinceTenrisMirkblood.CastBloodMirror, math.random(26000, 42000), 0)
    creature:RegisterEvent(PrinceTenrisMirkblood.CastSanguineSpirit, math.random(12000, 18000), 0)
    creature:RegisterEvent(PrinceTenrisMirkblood.CastSanguineStrike, math.random(11000, 19000), 0)
    creature:RegisterEvent(PrinceTenrisMirkblood.CastBloodSwoop, 23000, 0)
end

function PrinceTenrisMirkblood.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function PrinceTenrisMirkblood.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(PrinceTenrisMirkblood.NPC_ID, 1, PrinceTenrisMirkblood.OnEnterCombat)
RegisterCreatureEvent(PrinceTenrisMirkblood.NPC_ID, 2, PrinceTenrisMirkblood.OnLeaveCombat)
RegisterCreatureEvent(PrinceTenrisMirkblood.NPC_ID, 4, PrinceTenrisMirkblood.OnDied)
