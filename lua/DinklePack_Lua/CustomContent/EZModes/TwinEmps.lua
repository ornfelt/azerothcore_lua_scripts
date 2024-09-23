local TwinEmpsHelper = {}

TwinEmpsHelper.NPC_ID = 400158
TwinEmpsHelper.TARGET_CREATURE_ID = 15276
TwinEmpsHelper.SPELL_ID = 75215
TwinEmpsHelper.SEARCH_RANGE = 1000
TwinEmpsHelper.CAST_DELAY = 30000 
TwinEmpsHelper.DESPAWN_DELAY = 300000 -- 5 minutes
TwinEmpsHelper.MOVE_DELAY_1 = 1000 -- 1 second
TwinEmpsHelper.MOVE_DELAY_2 = 11600 -- 11.6 seconds
TwinEmpsHelper.GOSSIP_ACTIVATED = "gossipActivated"
TwinEmpsHelper.COUNTDOWN_START_DELAY = 40000 -- 40 seconds
TwinEmpsHelper.COUNTDOWN_INTERVAL = 1000 -- 1 second

local function CastSpellOnTarget(eventId, delay, repeats, creature)
    local creaturesInRange = creature:GetCreaturesInRange(TwinEmpsHelper.SEARCH_RANGE, TwinEmpsHelper.TARGET_CREATURE_ID)
    
    if #creaturesInRange > 0 then
        local target = creaturesInRange[1]
        creature:CastSpell(target, TwinEmpsHelper.SPELL_ID, true)
    end
    
    -- Casting additional spells on itself
    creature:CastSpell(creature, 71495, true)
    creature:CastSpell(creature, 52052, true)
    creature:CastSpell(creature, 13520, true)
end

local function MoveToFirstWaypoint(eventId, delay, repeats, creature)
    creature:MoveTo(1, -8954.459, 1236.307, -112.62)
    creature:RegisterEvent(TwinEmpsHelper.MoveToSecondWaypoint, TwinEmpsHelper.MOVE_DELAY_2, 1)
end

function TwinEmpsHelper.MoveToSecondWaypoint(eventId, delay, repeats, creature)
    creature:MoveTo(2, -8943.568, 1231.81, -112.62)
    creature:SetHomePosition(-8943.568, 1231.81, -112.62, 0)
end

local function Countdown5(eventId, delay, repeats, creature) creature:SendUnitYell("Going in 5...", 0) end
local function Countdown4(eventId, delay, repeats, creature) creature:SendUnitYell("4...", 0) end
local function Countdown3(eventId, delay, repeats, creature) creature:SendUnitYell("3...", 0) end
local function Countdown2(eventId, delay, repeats, creature) creature:SendUnitYell("2...", 0) end
local function Countdown1(eventId, delay, repeats, creature) creature:SendUnitYell("1...", 0) end
local function Boom(eventId, delay, repeats, creature) creature:SendUnitYell("BOOM!!!", 0) end

local CountdownFunctions = {Countdown5, Countdown4, Countdown3, Countdown2, Countdown1, Boom}

local function OnGossipSelect(event, player, creature, sender, intid, code)
    if intid == 1 then
        creature:SetData(TwinEmpsHelper.GOSSIP_ACTIVATED, 1)
        creature:RegisterEvent(MoveToFirstWaypoint, TwinEmpsHelper.MOVE_DELAY_1, 1)
        
        -- Register the countdown events
        for i = 1, #CountdownFunctions do
            creature:RegisterEvent(CountdownFunctions[i], 25000 + (i - 1) * 1000, 1)
        end
        
        creature:RegisterEvent(CastSpellOnTarget, TwinEmpsHelper.CAST_DELAY, 1)
        
        creature:SendUnitSay("Alright, let's do this!", 0)
        creature:PerformEmote(388)
    end
    player:GossipComplete()
end

local function OnGossipHello(event, player, creature)
    if creature:GetData(TwinEmpsHelper.GOSSIP_ACTIVATED) ~= 1 then
        player:GossipMenuAddItem(0, "Yes, please help.", 1, 1)
        creature:SendUnitSay("How about we give Vek'lor a chain reaction he won’t forget? Rooted in place, like a tree!", 0)
        player:GossipSendMenu(1, creature)
    end
end

local function OnCreatureDeath(event, creature, killer)
    creature:RemoveEvents()
    creature:SetData(TwinEmpsHelper.GOSSIP_ACTIVATED, 0)
end

local function OnLeaveCombat(event, creature)
    creature:RegisterEvent(TwinEmpsHelper.DespawnCreature, TwinEmpsHelper.DESPAWN_DELAY, 1)
end

RegisterCreatureGossipEvent(TwinEmpsHelper.NPC_ID, 1, OnGossipHello)
RegisterCreatureGossipEvent(TwinEmpsHelper.NPC_ID, 2, OnGossipSelect)
RegisterCreatureEvent(TwinEmpsHelper.NPC_ID, 4, OnCreatureDeath)
RegisterCreatureEvent(TwinEmpsHelper.NPC_ID, 2, OnLeaveCombat)
