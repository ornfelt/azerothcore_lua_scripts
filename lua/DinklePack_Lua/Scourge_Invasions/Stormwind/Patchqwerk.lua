local Patchqwerk = {}

Patchqwerk.NPC_ID = 400012
Patchqwerk.CREATURE_SPAWN_ID = 400120
Patchqwerk.SPELL_IDS = {
    HATEFUL_STRIKE = 28308,
    GORE = 48130,
    POISON_BOLT_VOLLEY = 25991,
    BERSERK = 41305,
    SPAWN_SPELL = 46587
}

Patchqwerk.YELL_OPTIONS_COMBAT_ENTER = { 
    "Patchqwerk huuuuungry!", 
    "Time for a snack!", 
    "You my new toy now!", 
    "You look delicious. Patchqwerk eat you now!", 
    "I not eat in days, time to feast!", 
    "Me smash and eat you now!", 
    "Me so hungry, me eat anything... even you!" 
}

Patchqwerk.YELL_OPTIONS_COMBAT_LEAVE = { 
    "You not so tasty afterall...", 
    "I be back for seconds!", 
    "No more play? Too bad...", 
    "Maybe next time you taste better!",
    "Me still hungry, come back later!",
    "You not enough food, me go find more!", 
    "Aww...You no stay for dinner? You make Patchqwerk sad." 
}

local function SelectRandomYell(yellOptions)
    local randomIndex = math.random(1, #yellOptions)
    return yellOptions[randomIndex]
end

local function SendRandomYell(creature, yellOptions)
    if (math.random(1, 100) <= 25) then
        creature:SendUnitYell(SelectRandomYell(yellOptions), 0)
    end
end

function Patchqwerk.CastHatefulStrike(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Patchqwerk.SPELL_IDS.HATEFUL_STRIKE, true)
end

function Patchqwerk.CastGore(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Patchqwerk.SPELL_IDS.GORE, true)
end

function Patchqwerk.PoisonBoltVolley(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Patchqwerk.SPELL_IDS.POISON_BOLT_VOLLEY, true)
end

function Patchqwerk.OnSpawn(event, creature)
    creature:SendUnitYell("Patchqwerk make Lich King proud! You die now!", 0)
    creature:CastSpell(creature, Patchqwerk.SPELL_IDS.SPAWN_SPELL, true)
end

function Patchqwerk.OnEnterCombat(event, creature, target)
    SendRandomYell(creature, Patchqwerk.YELL_OPTIONS_COMBAT_ENTER)
    creature:RegisterEvent(Patchqwerk.PoisonBoltVolley, 7000, 0)
    creature:RegisterEvent(Patchqwerk.CastHatefulStrike, 15000, 0)
    creature:RegisterEvent(Patchqwerk.CastGore, 20000, 0)
end

function Patchqwerk.OnLeaveCombat(event, creature)
    SendRandomYell(creature, Patchqwerk.YELL_OPTIONS_COMBAT_LEAVE)
    creature:RemoveEvents()
end

function Patchqwerk.OnDied(event, creature, killer)
    creature:SendUnitYell("Patchqwerk forget to chew...", 0)
    if(killer:GetObjectType() == "Player") then
        killer:SendBroadcastMessage("You killed " .. creature:GetName() .. "!")
    end
    local x, y, z, o = creature:GetLocation()
    creature:SpawnCreature(Patchqwerk.CREATURE_SPAWN_ID, x, y, z, o, 3, 900000)
    creature:RemoveEvents()
end

function Patchqwerk.CheckHealth(event, creature)
    if (creature:HealthBelowPct(20)) then
        creature:SendUnitYell("Patchqwerk go berserk!", 0)
        creature:CastSpell(creature, Patchqwerk.SPELL_IDS.BERSERK, true)
    end
end

-- Registering events
RegisterCreatureEvent(Patchqwerk.NPC_ID, 1, Patchqwerk.OnEnterCombat)
RegisterCreatureEvent(Patchqwerk.NPC_ID, 2, Patchqwerk.OnLeaveCombat)
RegisterCreatureEvent(Patchqwerk.NPC_ID, 4, Patchqwerk.OnDied)
RegisterCreatureEvent(Patchqwerk.NPC_ID, 5, Patchqwerk.OnSpawn)
RegisterCreatureEvent(Patchqwerk.NPC_ID, 6, Patchqwerk.CheckHealth)
