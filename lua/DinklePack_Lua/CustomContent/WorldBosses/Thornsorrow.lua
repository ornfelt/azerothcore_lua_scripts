local Thornsorrow = {}
Thornsorrow.spellQueue = {}

local SPELL_NIGHTMARE_GRASP = 12345 -- replace with actual spell IDs
local SPELL_CORRUPTED_BARK = 12346
local SPELL_SICKENING_POLLEN = 12347
local SPELL_CURSED_SAPLINGS = 12348
local SPELL_NIGHTMARE_BLAST = 12349

local MELEE_TARGET_LOOKUP_DIST = 10.0

function Thornsorrow.CastNightmareGrasp(eventId, delay, calls, creature)
    table.insert(Thornsorrow.spellQueue, {spell = SPELL_NIGHTMARE_GRASP, targetType = 'random'})
end

function Thornsorrow.CastCorruptedBark(eventId, delay, calls, creature)
    table.insert(Thornsorrow.spellQueue, {spell = SPELL_CORRUPTED_BARK, targetType = 'self', emote = "Thornsorrow's bark hardens, reducing damage taken!"})
end

function Thornsorrow.CastSickeningPollen(eventId, delay, calls, creature)
    table.insert(Thornsorrow.spellQueue, {spell = SPELL_SICKENING_POLLEN, targetType = 'self'})
end

function Thornsorrow.CastCursedSaplings(eventId, delay, calls, creature)
    table.insert(Thornsorrow.spellQueue, {spell = SPELL_CURSED_SAPLINGS, targetType = 'self'})
end

function Thornsorrow.CastNightmareBlast(eventId, delay, calls, creature)
    table.insert(Thornsorrow.spellQueue, {spell = SPELL_NIGHTMARE_BLAST, targetType = 'self', emote = "Thornsorrow releases a massive blast of nightmare energy!"})
end

function Thornsorrow.ProcessSpellQueue(eventId, delay, calls, creature)
    if not creature:IsCasting() and #Thornsorrow.spellQueue > 0 then
        local nextSpell = table.remove(Thornsorrow.spellQueue, 1)
        local target

        if nextSpell.targetType == 'self' then
            target = creature
        elseif nextSpell.targetType == 'victim' then
            target = creature:GetVictim()
        elseif nextSpell.targetType == 'random' then
            local targets = creature:GetAITargets(nextSpell.range or 0)
            if #targets > 0 then
                target = targets[math.random(1, #targets)]
            end
        end

        if target then
            creature:CastSpell(target, nextSpell.spell, false)
            if nextSpell.emote then
                creature:SendUnitEmote(nextSpell.emote)
            end
        end
    end
end

function Thornsorrow.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(Thornsorrow.CastNightmareGrasp, math.random(12000, 16000), 0)
    creature:RegisterEvent(Thornsorrow.CastCorruptedBark, math.random(20000, 25000), 0)
    creature:RegisterEvent(Thornsorrow.CastSickeningPollen, math.random(8000, 10000), 0)
    creature:RegisterEvent(Thornsorrow.CastCursedSaplings, math.random(6000, 9000), 0)
    creature:RegisterEvent(Thornsorrow.CastNightmareBlast, 45000, 0)
    creature:RegisterEvent(Thornsorrow.ProcessSpellQueue, 2000, 0) -- Process the spell queue every 2 seconds
end

function Thornsorrow.OnLeaveCombat(event, creature)
    creature:RemoveEvents() -- remove all registered events
    Thornsorrow.spellQueue = {} -- clear the spell queue
end

function Thornsorrow.OnDied(event, creature, killer)
    creature:RemoveEvents() -- remove all registered events
    Thornsorrow.spellQueue = {} -- clear the spell queue
end

RegisterCreatureEvent(123456, 1, Thornsorrow.OnEnterCombat) -- replace 123456 with actual creature ID
RegisterCreatureEvent(123456, 2, Thornsorrow.OnLeaveCombat)
RegisterCreatureEvent(123456, 4, Thornsorrow.OnDied)
