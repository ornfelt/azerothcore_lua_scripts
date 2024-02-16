Hazzrash = {}
Hazzrash.spellQueue = {}
Hazzrash.processSpellQueueEventId = nil
Hazzrash.resumeCastsEventId = nil

function Hazzrash.AddSpellToQueue(spell, targetType, range)
    table.insert(Hazzrash.spellQueue, {spell = spell, targetType = targetType, range = range})
end

function Hazzrash.ProcessSpellQueue(eventId, delay, calls, creature)
    if not creature:IsCasting() and #Hazzrash.spellQueue > 0 then
        local nextSpell = table.remove(Hazzrash.spellQueue, 1)
        local target

        if nextSpell.targetType == 'victim' then
            target = creature:GetVictim()
        elseif nextSpell.targetType == 'random' then
            local targets = creature:GetAITargets(nextSpell.range or 0)
            if #targets > 0 then
                target = targets[math.random(1, #targets)]
            end
        end

        if target then
            creature:CastSpell(target, nextSpell.spell, false)
        end
    end
end

function Hazzrash.CastEvocation(eventId, delay, calls, creature)
    creature:CastSpell(creature, 30254, true)
    if Hazzrash.processSpellQueueEventId then
        creature:RemoveEventById(Hazzrash.processSpellQueueEventId)
    end
    if Hazzrash.resumeCastsEventId then
        creature:RemoveEventById(Hazzrash.resumeCastsEventId)
    end
    Hazzrash.processSpellQueueEventId = creature:RegisterEvent(Hazzrash.ProcessSpellQueue, 2000, 0)
    Hazzrash.resumeCastsEventId = creature:RegisterEvent(Hazzrash.ResumeCasts, 20000, 1)
end

function Hazzrash.ResumeCasts(eventId, delay, calls, creature)
    creature:RegisterEvent(function() Hazzrash.AddSpellToQueue(44425, 'victim') end, 6000, 0) -- Arcane Barrage
    creature:RegisterEvent(function() Hazzrash.AddSpellToQueue(30451, 'random', 10) end, 14000, 0) -- Arcane Blast
    creature:RegisterEvent(function() Hazzrash.AddSpellToQueue(8211, 'random', 10) end, 29000, 0) -- Chain Burn
    creature:RegisterEvent(function() Hazzrash.AddSpellToQueue(5106, 'victim') end, 20000, 0) -- Crystal Flash
end

function Hazzrash.OnEnterCombat(event, creature, target)
    Hazzrash.processSpellQueueEventId = creature:RegisterEvent(Hazzrash.ProcessSpellQueue, 2000, 0)
    Hazzrash.resumeCastsEventId = creature:RegisterEvent(Hazzrash.ResumeCasts, 1, 1)
    creature:RegisterEvent(Hazzrash.CastEvocation, 48000, 1)
    creature:RegisterEvent(Hazzrash.CastEvocation, 108000, 1)
    creature:RegisterEvent(Hazzrash.CastEvocation, 176000, 1)
end

function Hazzrash.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
    Hazzrash.spellQueue = {}
end

function Hazzrash.OnDied(event, creature, killer)
    creature:RemoveEvents()
    Hazzrash.spellQueue = {}
end

function Hazzrash.CheckForShazzrah(eventId, delay, calls, creature)
    local shazzrah = creature:GetCreaturesInRange(100, 12264, 0, 1)
    if #shazzrah == 0 then
        creature:DespawnOrUnsummon()
    else
        --creature:SetMaxHealth(563000)
    end
end

function Hazzrash.OnSpawn(event, creature)
    creature:RegisterEvent(Hazzrash.CheckForShazzrah, 3000, 1) -- Register the check for Shazzrah to a 3 second delay
end

RegisterCreatureEvent(83000, 1, Hazzrash.OnEnterCombat)
RegisterCreatureEvent(83000, 2, Hazzrash.OnLeaveCombat)
RegisterCreatureEvent(83000, 4, Hazzrash.OnDied)
RegisterCreatureEvent(83000, 5, Hazzrash.OnSpawn)
