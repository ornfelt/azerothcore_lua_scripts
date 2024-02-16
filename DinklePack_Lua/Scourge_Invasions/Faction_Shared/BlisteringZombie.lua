local BLISTERING_ONE_NPC_ID = 400029

BlisteringZombieOne = {}

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

function BlisteringZombieOne.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CastSpit, 5000, 0)
    creature:RegisterEvent(CastSpecialSpell, 1000, 0)
end

function BlisteringZombieOne.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function BlisteringZombieOne.OnDied(event, creature, killer)
    creature:DespawnOrUnsummon(5000)
    creature:RemoveEvents()
end

RegisterCreatureEvent(BLISTERING_ONE_NPC_ID, 1, BlisteringZombieOne.OnEnterCombat)
RegisterCreatureEvent(BLISTERING_ONE_NPC_ID, 2, BlisteringZombieOne.OnLeaveCombat)
RegisterCreatureEvent(BLISTERING_ONE_NPC_ID, 4, BlisteringZombieOne.OnDied)
