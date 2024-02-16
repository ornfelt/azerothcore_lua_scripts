--[[

local NPC_IDS = {401111}
local ITEM_ID = 60124

local mainHandItems = {132475, 175930, 178507}

local messages = {
    "We fight for peace.",
    "Only together, we can save Azeroth!",
    "Let's show these villains the power of unity!",
    "For Azeroth!",
    "We shall overcome!",
    "This land is ours, and we will defend it with our lives!",
    "Together, we are invincible!",
}

local weaponMessages = {
    "Ah, the Scythe of Elune, a formidable choice!",
    "A Battle Axe, excellent. Let's bring the fight to them!",
    "Stalwart Sword, very well. We shall strike true!",
}

local function OnGossipHello(event, player, creature)
    if player:HasItem(ITEM_ID) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(8, "|TInterface\\icons\\inv_sword_39:40:40:-35|t|cff610B0BGive Staff|r", 1, 0)
        player:GossipMenuAddItem(9, "Scythe of Elune", 1, 1001)
        player:GossipMenuAddItem(9, "Battle Axe", 1, 1002)
        player:GossipMenuAddItem(9, "Stalwart Sword", 1, 1003)
        player:GossipSendMenu(1, creature)
    else
        player:SendBroadcastMessage("You need the right staff to arm me!")
    end
end

local function CastArcaneBlast(eventId, delay, calls, creature)
    if creature:IsInCombat() then
        creature:CastSpell(creature:GetVictim(), 30451, true) -- Arcane Blast
    end
end

local function CastFrostbolt(eventId, delay, calls, creature)
    if creature:IsInCombat() then
        creature:CastSpell(creature:GetVictim(), 116, true) -- Frostbolt
    end
end

local function CastFireball(eventId, delay, calls, creature)
    if creature:IsInCombat() then
        creature:CastSpell(creature:GetVictim(), 133, true) -- Fireball
    end
end

local function RegisterAbilities(creature, weaponType)
    if creature:GetData("abilitiesRegistered") then
        return
    end
    creature:SetData("abilitiesRegistered", true)

    if weaponType == 1 then -- Staff of Elune Abilities
        creature:RegisterEvent(CastArcaneBlast, math.random(2000, 2000), 0)
    elseif weaponType == 2 then -- Staff of Antiquities Abilities
        creature:RegisterEvent(CastFrostbolt, math.random(2000, 2000), 0)
    elseif weaponType == 3 then -- Staff of Conjuring Abilities
        creature:RegisterEvent(CastFireball, math.random(2000, 2000), 0)
    end
end

local function OnGossipSelect(event, player, creature, sender, intid, code)
    if intid == 0 then
        OnGossipHello(event, player, creature)
    elseif intid >= 1001 and intid <= 1003 then
        local index = intid - 1000
        local selectedMainHand = mainHandItems[index]
        creature:SetEquipmentSlots(0, selectedMainHand, 0)
        creature:SetData("weaponType", index)
        creature:SetData("equipmentSet", true)
        creature:PerformEmote(66)
        creature:SendUnitSay(weaponMessages[index], 0)
        RegisterAbilities(creature, index)
        OnGossipHello(event, player, creature)
    end
    player:GossipComplete()
end

local function OnEnterCombat(event, creature, target)
    creature:SendUnitSay(messages[math.random(1, #messages)], 0)
    creature:AttackStart(target)
    RegisterAbilities(creature, creature:GetData("weaponType"))
end


local function OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function OnReset(event, creature)
    -- No follow reset action needed as we removed the follow feature
end

local function OnDied(event, creature, killer)
    creature:RemoveEvents() -- Stop all events when the creature dies
end

for i, v in ipairs(NPC_IDS) do
    RegisterCreatureGossipEvent(v, 1, OnGossipHello)
    RegisterCreatureGossipEvent(v, 2, OnGossipSelect)
    RegisterCreatureEvent(v, 1, OnEnterCombat) -- Event 1 = CREATURE_EVENT_ON_ENTER_COMBAT
    RegisterCreatureEvent(v, 2, OnLeaveCombat) -- Event 2 = CREATURE_EVENT_ON_LEAVE_COMBAT
    RegisterCreatureEvent(v, 4, OnDied) -- Event 4 = CREATURE_EVENT_ON_DIED
    RegisterCreatureEvent(v, 23, OnReset) -- Event 23 = CREATURE_EVENT_ON_RESET
end
]]

