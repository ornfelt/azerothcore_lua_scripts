-- We create a 'box' (aka 'namespace') to keep all our code for this NPC in one place. 
-- We appropriately call this box 'TurretBoi'.
local TurretBoi = {}

-- We tell the game which NPC this script is for by specifying its ID number. 
-- Since we'll be using TurretBoi.NPC_ID in mulitple parts of the script,  we want to define it.
-- This also makes it much easier to change later on if we need to do so since all we need to change is one npcid.
TurretBoi.NPC_ID = 832350  

-- We make a list of spells this NPC will use. Right now, it's just one spell.
TurretBoi.SPELL_IDS = {
    SPELL_TO_CAST = 38083  -- The spell this NPC will cast.
	-- You can put more spells here:
	-- SECOND_SPELL_TO_CAST = 123456
}

-- When this NPC needs to cast a spell, this function gets called.
-- Don't worry about the 'eventId', 'delay', and 'repeats' stuff, they are just placeholders we have to include. 
-- See notes below.
function TurretBoi.CastSpell(eventId, delay, repeats, creature)
    -- The NPC casts the spell on whomever it's fighting.
	-- 'creature:GetVictim' means that the creature is attacking it's current (highest threat) target
	-- The 'true' statement at the end tells the creature to cast this spell instantly and free (0 mana, energy, etc).
	---- If you have more than one spell being cast in combat, this is the easiest way to prevent the npc from interrupting itself. 
	---- You can of course work around this to ensure no other spell is being cast, but then it will skip over said spell.
	---- The better alternative is create a que system which allows the first cast to go through, puts the second cast on standby, and casts it after some time has passed.
	---- For the purposes of this guide, that's way too complicated. I've included an example at the very bottom of the script though.
    creature:CastSpell(creature:GetVictim(), TurretBoi.SPELL_IDS.SPELL_TO_CAST, true)
end

-- *If you wanted a second spell to cast, you'd define it the same way as above:
--function TurretBoi.CastSecondSpell(eventId, delay, repeats, creature)
--    creature:CastSpell(creature:GetVictim(), TurretBoi.SPELL_IDS.SECOND_SPELL_TO_CAST, true)
--end


-- This function runs when the NPC starts fighting.
function TurretBoi.OnEnterCombat(event, creature)
    -- We set up the NPC to cast its spell every 3 seconds in milliseconds.
	-- 0 means it repeats over and over. Setting this number to 1 would make it happen only once, for example.
    creature:RegisterEvent(TurretBoi.CastSpell, 3000, 0) 
	-- *Here's also where you'd add an event to cast a second spell
	-- creature:RegisterEvent(TurretBoi.CastSecondSpell, 7000, 0) 
end

-- This function runs when the NPC stops fighting.
function TurretBoi.OnLeaveCombat(event, creature)
    -- We tell the NPC to forget any special actions we set up earlier.
	-- This is important for saving memory and making sure events don't just keep happning.
	-- It's basically telling the script 'Hey, we're done!'
    creature:RemoveEvents()  
end

-- This function runs when the NPC dies.
function TurretBoi.OnDied(event, creature)
    -- Again, we tell the NPC to forget any special actions we set up earlier.
    creature:RemoveEvents()  
end

-- We tell the game to use the above functions when certain things happen to the NPC.
-- You can find these 'hooks' in modules/mod-eluna/src/LuaEngine/Hooks.h
-- Basically when A happens, make B happen too.
RegisterCreatureEvent(TurretBoi.NPC_ID, 1, TurretBoi.OnEnterCombat)
RegisterCreatureEvent(TurretBoi.NPC_ID, 2, TurretBoi.OnLeaveCombat)
RegisterCreatureEvent(TurretBoi.NPC_ID, 4, TurretBoi.OnDied)

--------------------------------
--------------------------------
-- ADDITIONAL NOTES
--------------------------------
--------------------------------

-- Question: Why do we need to include placeholders (arguments) like 'eventId', 'delay', and 'repeats' even if we don't use them?
-- Think of it like a handshake. Both sides expect it to go a certain way. 
-- If we leave out any part, the handshake fails, and the game might act weird or crash.

-- Question: How do you know what placeholders ('eventId', 'delay', etc.) to include in the first place?
-- This comes from reading the manual, looking at examples, and sometimes asking other people who know. 
-- If we get it wrong, the game will usually give us a hint about what's missing.

-- Question: What's the deal with this 'TurretBoi' box we keep everything in?
-- Putting all related things in one 'box' (we call it a namespace) helps keep our script tidy and makes sure it doesn't mess with other scripts. 
-- It's like giving it its own room with a nameplate.

-- Question: Any downsides to using these 'boxes' or namespaces?
-- Yes, if you're new, this can look confusing. 
-- Also, if you're not careful, you could end up using more computer memory. 
-- Lastly, if you put everything in separate 'boxes', it might be hard to make them talk to each other.

---------------------------------
---------------------------------
-- CUSTOM MAGMADAR FIGHT EXAMPLE
---------------------------------
---------------------------------

--[[

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
local SPELL_SUMMON_CORE_HOUND = 364726 -- this is a custom spell i made to summon core hounds
local SPELL_ENRAGE = 27680

-- Defines a range to look up the distance necessary to cast "ranged" Lava Bomb as he targets melee and ranged seperately. 
local MELEE_TARGET_LOOKUP_DIST = 10.0

-- Periodically casts frenzy on self with the emote broadcast to players to be more blizzlike
function Magmadar.CastFrenzy(eventId, delay, calls, creature)
    table.insert(Magmadar.spellQueue, {spell = SPELL_FRENZY, targetType = 'self', emote = "Magmadar goes into a killing Frenzy!"})
end

-- Casts panic, an aoe spell. You could have this spell target anyone since it's aoe so I just decided to have it cast on the current victim to make things simple
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

-- This is the actual spell que system
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
    creature:RegisterEvent(Magmadar.CastSummonCoreHound, 55000, 0)
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
]]--