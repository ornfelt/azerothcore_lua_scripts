-- Defines a table to store functions and variables for Magmadar throughout the fight
local Magmadar = {}
-- Initialize a table to store a queue of spells. 
-- This is a system I came up with so that bosses won't interrupt themselves with their own spell casts and skip certain spells. 
-- If you have skipcheck set to true on spell casts, 
-- hen you do not need a spell que system since all spells will be cast instantly and not interrupt eachother.
Magmadar.spellQueue = {}


-- Defines a list of spells. You can always call these directly with the ID number instead directly in the cast functions.
local SPELL_FRENZY = 19451
local SPELL_PANIC = 19408
local SPELL_LAVA_BOMB = 19411
local SPELL_LAVA_BOMB_RANGED = 20474
local SPELL_SUMMON_CORE_HOUND = 364726
local SPELL_ENRAGE = 27680

-- Defines a range to look up the distance necessary to cast "ranged" Lava Bomb as he targets melee and ranged seperately. 
local MELEE_TARGET_LOOKUP_DIST = 10.0

-- Periodically casts frenzy on self with the emote broadcast to players to be more blizzlike
function Magmadar.CastFrenzy(eventId, delay, calls, creature)
    table.insert(Magmadar.spellQueue, {spell = SPELL_FRENZY, targetType = 'self', emote = "Magmadar goes into a killing Frenzy!"})
end

-- Casts panic, an aoe spell. You could hae this spell target anyone since it's aoe so I just decided to have it cast on the current victim to make things simple
function Magmadar.CastPanic(eventId, delay, calls, creature)
    table.insert(Magmadar.spellQueue, {spell = SPELL_PANIC, targetType = 'victim'})
end

-- This is the function for melee lava bomb. Selects from a random pool of ai targets, which will include bots. ai targets are threat targets on Magmadar's table. Alternatively could have set this to only cast on players.
function Magmadar.CastLavaBomb(eventId, delay, calls, creature)
    table.insert(Magmadar.spellQueue, {spell = SPELL_LAVA_BOMB, targetType = 'random', range = MELEE_TARGET_LOOKUP_DIST, maxRange = false}) -- this is set to false so that Magmadar does not check range of players prior to casting.
end

-- Ranged lavabomb function
function Magmadar.CastLavaBombRanged(eventId, delay, calls, creature)
    table.insert(Magmadar.spellQueue, {spell = SPELL_LAVA_BOMB_RANGED, targetType = 'random', range = MELEE_TARGET_LOOKUP_DIST, maxRange = true}) -- this is set to true to cast lava bomb on ranged targets.
end

-- periodically summons corehounds. Any spells that are flagged as unit target caster should be cast on the creature itself
function Magmadar.CastSummonCoreHound(eventId, delay, calls, creature)
    table.insert(Magmadar.spellQueue, {spell = SPELL_SUMMON_CORE_HOUND, targetType = 'self'})
end

-- This is an enrage funciton i put on magmadar as a dps check that will cast after 3 minutes
function Magmadar.CastEnrage(eventId, delay, calls, creature)
    table.insert(Magmadar.spellQueue, {spell = SPELL_ENRAGE, targetType = 'self', emote = "Magmadar becomes enraged, significantly increasing attack speed and damage!"})
end

-- This is the actuall spell que system
-- Determine's target based on the targetType property
        -- 'self' targets the creature itself
        -- 'victim' targets the creature's current target (its victim)
        -- 'random' targets a random entity within the range, or outside of it if maxRange is set to true
        -- The target is determined using the creature's AI targets, which includes both players and NPCs
        -- If there are multiple targets in range, one is selected randomly
		-- If a target is determined, the creature casts the spell at the target.
		-- If the spell in the queue has an emote associated with it, the creature also sends that emote.
function Magmadar.ProcessSpellQueue(eventId, delay, calls, creature)
    if not creature:IsCasting() and #Magmadar.spellQueue > 0 then
        local nextSpell = table.remove(Magmadar.spellQueue, 1)
        local target

        if nextSpell.targetType == 'self' then
            target = creature
        elseif nextSpell.targetType == 'victim' then
            target = creature:GetVictim()
        elseif nextSpell.targetType == 'random' then
            local targets = creature:GetAITargets(nextSpell.range or 0)
            if #targets > 0 then
                if nextSpell.maxRange then
                    for _, t in pairs(targets) do
                        if t:GetDistance(creature) > nextSpell.range then
                            target = t
                            break
                        end
                    end
                else
                    target = targets[math.random(1, #targets)]
                end
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

-- Enter combat functions, registering defined spell-casting events with random intervals.
-- Additionally, Magmadar regularly checks its spell queue.
function Magmadar.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(Magmadar.CastFrenzy, math.random(12000, 16000), 0) -- example: casts frenzy between 12-16 seconds if is not casting, otherwise casts it directly afterwards
    creature:RegisterEvent(Magmadar.CastPanic, math.random(20000, 25000), 0)
    creature:RegisterEvent(Magmadar.CastLavaBomb, math.random(8000, 10000), 0)
    creature:RegisterEvent(Magmadar.CastLavaBombRanged, math.random(9000, 12000), 0)
    creature:RegisterEvent(Magmadar.CastSummonCoreHound, 45000, 0)
    creature:RegisterEvent(Magmadar.CastEnrage, 300000, 1) -- 5 minute enrage timer
    creature:RegisterEvent(Magmadar.ProcessSpellQueue, 2000, 0)
end

-- When the creature leaves combat, it removes all its events and clears the spell queue, otherwise he continues to cast and process functions
function Magmadar.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
    Magmadar.spellQueue = {}
end

-- When the creature dies, it removes all its events and clears the spell queue, otherwise he continues to cast even while died lol
function Magmadar.OnDied(event, creature, killer)
    creature:RemoveEvents()
    Magmadar.spellQueue = {}
end

-- Registers events with the Magmadar based on its creature_template ID (11982)
-- The numbers correspond to: 1 - when the creature enters combat, 2 - when the creature leaves combat, 4 - when the creature dies.
RegisterCreatureEvent(11982, 1, Magmadar.OnEnterCombat)
RegisterCreatureEvent(11982, 2, Magmadar.OnLeaveCombat)
RegisterCreatureEvent(11982, 4, Magmadar.OnDied)
